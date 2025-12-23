using Demo05.Data;
using Demo05.Models;
using Demo05.ViewModel;
using Microsoft.EntityFrameworkCore;
using Microsoft.SemanticKernel.Embeddings;
using OllamaSharp;
using Pgvector.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);
var cnnStr = builder.Configuration.GetConnectionString("DefaultConnection");

builder.Services.AddDbContext<AppDbContext>(x =>
{
	x.UseNpgsql(cnnStr, p => p.UseVector());
});

builder.Services.AddTransient<OllamaApiClient>(x => new OllamaApiClient(
	uriString: "http://localhost:11434", defaultModel: "mxbai-embed-large:335m"));

var app = builder.Build();

app.MapGet("/", () => "Hello World!");

app.MapGet("v1/seed", async (AppDbContext context, OllamaApiClient ollama) =>
{
	var products = await context.Products.AsNoTracking().ToListAsync();

	foreach (var product in products)
	{
		var service = ollama.AsTextEmbeddingGenerationService();
		var embeddings = await service.GenerateEmbeddingAsync(product.Category);

		var recomendation = new Recomendation
		{
			Title = product.Title,
			Category = product.Category,
			Embedding = new Pgvector.Vector(embeddings)
		};

		await context.Recomendations.AddAsync(recomendation);
		await context.SaveChangesAsync();
	}

	return Results.Ok(new { message = "OK" });
});

app.MapPost("v1/products", async (CreateProductViewModel model, AppDbContext context, OllamaApiClient ollama) =>
{
	var product = new Product
	{
		Title = model.Title,
		Summary = model.Summary,
		Category = model.Category,
		Description = model.Description
	};
	await context.Products.AddAsync(product);

	var service = ollama.AsTextEmbeddingGenerationService();
	var embeddings = await service.GenerateEmbeddingAsync(product.Category);

	var recomendation = new Recomendation
	{
		Title = model.Title,
		Category = model.Category,
		Embedding = new Pgvector.Vector(embeddings)
	};
	await context.Recomendations.AddAsync(recomendation);

	await context.SaveChangesAsync();

	return Results.Created();
});

app.MapPost("v1/prompt", async (QuestionViewModel model, AppDbContext context, OllamaApiClient ollama) =>
{
	var service = ollama.AsTextEmbeddingGenerationService();
	var embeddings = await service.GenerateEmbeddingAsync(model.Prompt);

	var recomendations = await context.Recomendations
		.AsNoTracking()
		.OrderBy(x => x.Embedding.CosineDistance(new Pgvector.Vector(embeddings.ToArray())))
		.Take(10)
		.Select(x => new { x.Title, x.Category })
		.ToListAsync();

	return Results.Ok(recomendations);
});

app.Run();