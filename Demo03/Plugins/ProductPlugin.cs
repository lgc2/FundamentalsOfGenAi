using System.ComponentModel;
using Microsoft.SemanticKernel;

namespace Demo03.Plugins;

public class ProductPlugin
{
	private List<Product> _products =
	[
		new (1, "Mousepad", true, 10),
		new (2, "Mouse Gamer", true, 8),
		new (3, "Teclado Gamer", true, 1),
		new (4, "Capa Monitor", false, 1),
		new (5, "Monitor Gamer", false, 5),
	];

	[KernelFunction("get_products")]
	[Description("Gets a list of products and their current status")]
	public async Task<List<Product>> GetProductsAsync()
	{
		await Task.Delay(1);
		return _products;
	}

	[KernelFunction("get_state")]
	[Description("Gets the state of a particular product")]
	public async Task<Product?> GetStateAsync([Description("The ID of the product")] int id)
	{
		await Task.Delay(1);
		return _products.FirstOrDefault(p => p.Id == id);
	}

	[KernelFunction("change_state")]
	[Description("Changes the state of a particular product")]
	public async Task<Product?> ChangeStateAsync(
		[Description("The ID of the product")] int id,
		[Description("The content of the product to be modified")] Product model)
	{
		await Task.Delay(1);

		if (id != model.Id) return null;

		var productIndex = _products.FindIndex(p => p.Id == id);

		if (productIndex == -1) return null;

		var product = new Product(model.Id, model.Title, model.IsActive, model.QuantityOnHand);
		_products[productIndex] = product;

		return product;
	}
}

public record Product(int Id, string Title, bool IsActive, int QuantityOnHand);
