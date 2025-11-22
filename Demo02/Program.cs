using Microsoft.Extensions.AI;
using OllamaSharp;

const string openAiKey = "CHAVE_DO_OPEN_AI";
var uri = new Uri("http://localhost:11434/");

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

var client = app.Environment.IsDevelopment()
	? new OllamaApiClient(uri, "phi3:3.8b")
	: new OpenAI.Chat.ChatClient("gpt-4o-mini", openAiKey).AsIChatClient();

app.MapPost("/", async (Question question) =>
{
	var response = await client.GetResponseAsync(question.Prompt);
	return Results.Ok(response.Text);
});

app.Run();

public record Question(string Prompt);
