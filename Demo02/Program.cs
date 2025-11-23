using Microsoft.Extensions.AI;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;
using OllamaSharp;

const string openAiKey = "CHAVE_DO_OPEN_AI";
var uri = new Uri("http://localhost:11434/");

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

IDistributedCache cache = new MemoryDistributedCache(Options.Create(new MemoryDistributedCacheOptions()));

var client = app.Environment.IsDevelopment()
	? new OllamaApiClient(uri, "phi3:3.8b")
	: new OpenAI.Chat.ChatClient("gpt-4o-mini", openAiKey).AsIChatClient();

var cachedClient = new ChatClientBuilder(client)
	.UseDistributedCache(cache)
	.Build();

app.MapPost("/", async (Question question) =>
{
	var response = await client.GetResponseAsync(question.Prompt);
	return Results.Ok(response.Text);
});

app.MapPost("/v2", async (Question question) =>
{
	var result = await client.GetResponseAsync(
		[
			new ChatMessage(ChatRole.System, "You are a very technical weather expert. Answer me in up to 10 words."),
			new ChatMessage(ChatRole.User, question.Prompt)
		]);
	return Results.Ok(result.Text);
});

app.MapPost("/v3", async (Question question) =>
{
	var result = await cachedClient.GetResponseAsync(
		[
			new ChatMessage(ChatRole.System, "You are a very technical weather expert. Answer me in up to 10 words."),
			new ChatMessage(ChatRole.User, question.Prompt)
		]);
	return Results.Ok(result.Text);
});

app.Run();

public record Question(string Prompt);
