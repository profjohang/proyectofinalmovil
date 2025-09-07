using Microsoft.AspNetCore.Mvc;
using ProductApi.Models;

namespace ProductApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProductController : ControllerBase
    {
    private static List<Product> products = new()
    {
        new Product { Id = 1, Name = "Auriculares Bluetooth", Description = "Auriculares inalámbricos con cancelación de ruido y batería de 20 horas.", Price = 120000, Category = "Audio" },
        new Product { Id = 2, Name = "Teclado Mecánico RGB", Description = "Teclado mecánico retroiluminado con switches azules.", Price = 250000, Category = "Periféricos" },
        new Product { Id = 3, Name = "Mouse Gamer Inalámbrico", Description = "Mouse ergonómico con sensor óptico de alta precisión.", Price = 80000, Category = "Periféricos" },
        new Product { Id = 4, Name = "Monitor LED 27''", Description = "Monitor Full HD con panel IPS y tasa de refresco de 144Hz.", Price = 950000, Category = "Pantallas" },
        new Product { Id = 5, Name = "Laptop Ultrabook", Description = "Laptop ligera con procesador Intel i7, 16GB RAM y SSD 512GB.", Price = 4800000, Category = "Computadores" },
        new Product { Id = 6, Name = "Disco Duro Externo 2TB", Description = "Disco duro portátil USB 3.0 de alta velocidad.", Price = 320000, Category = "Almacenamiento" },
        new Product { Id = 7, Name = "SSD NVMe 1TB", Description = "Unidad de estado sólido de alto rendimiento.", Price = 420000, Category = "Almacenamiento" },
        new Product { Id = 8, Name = "Router WiFi 6", Description = "Router de última generación con cobertura extendida.", Price = 370000, Category = "Redes" },
        new Product { Id = 9, Name = "Cámara Web 1080p", Description = "Cámara para streaming con micrófono incorporado.", Price = 160000, Category = "Accesorios" },
        new Product { Id = 10, Name = "Smartwatch Deportivo", Description = "Reloj inteligente con GPS y monitor de ritmo cardíaco.", Price = 350000, Category = "Wearables" },
        new Product { Id = 11, Name = "Tablet Android 10''", Description = "Tablet con pantalla HD y 64GB de almacenamiento.", Price = 780000, Category = "Tablets" },
        new Product { Id = 12, Name = "Smartphone 5G", Description = "Teléfono inteligente con cámara de 64MP y 128GB de memoria.", Price = 2100000, Category = "Celulares" },
        new Product { Id = 13, Name = "Cámara de Seguridad WiFi", Description = "Cámara IP con visión nocturna y detección de movimiento.", Price = 220000, Category = "Seguridad" },
        new Product { Id = 14, Name = "Parlante Inteligente", Description = "Altavoz con asistente de voz integrado.", Price = 300000, Category = "Audio" },
        new Product { Id = 15, Name = "Consola de Videojuegos", Description = "Consola de última generación con soporte 4K.", Price = 2800000, Category = "Gaming" },
        new Product { Id = 16, Name = "Joystick Inalámbrico", Description = "Control inalámbrico compatible con PC y consolas.", Price = 190000, Category = "Gaming" },
        new Product { Id = 17, Name = "Cámara Deportiva 4K", Description = "Cámara sumergible con grabación en 4K.", Price = 400000, Category = "Accesorios" },
        new Product { Id = 18, Name = "Impresora Multifuncional WiFi", Description = "Impresora láser con escáner y conexión inalámbrica.", Price = 680000, Category = "Oficina" },
        new Product { Id = 19, Name = "Auriculares Gamer con Micrófono", Description = "Headset con sonido envolvente 7.1 y luces RGB.", Price = 220000, Category = "Audio" },
        new Product { Id = 20, Name = "Drone con Cámara 4K", Description = "Drone plegable con GPS y cámara UHD estabilizada.", Price = 1200000, Category = "Drones" }
    };


        [HttpGet]
        [Route("GetProducts")]
        public IEnumerable<Product> GetUsers()
        {
            return products;
        }

        [HttpGet]
        [Route("GetProductsByParameter")]
        public IEnumerable<Product> GetUsersByParameter([FromHeader] string parameter)
        {
            if (string.IsNullOrWhiteSpace(parameter))
                return Enumerable.Empty<Product>();

            decimal ageFilter;
            bool isNumber = decimal.TryParse(parameter, out ageFilter);

            return products.Where(x =>
                x.Name.Contains(parameter, StringComparison.OrdinalIgnoreCase) ||
                (isNumber && x.Price == ageFilter) ||
                x.Category.Contains(parameter, StringComparison.OrdinalIgnoreCase)
            );
        }

        [HttpPost]
        [Route("CreateProduct")]
        public ActionResult<Product> CreateProduct([FromBody] RequestProduct product)
        {
            Product newProduct = new Product
            {
                Id = products.Last().Id + 1,
                Name = product.Name,
                Description = product.Description,
                Price = product.Price,
                Category = product.Category
            };

            products.Add(newProduct);

            return newProduct;
        }

        [HttpPost]
        [Route("UpdateProduct")]
        public ActionResult<Product> UpdateProduct([FromBody] Product product)
        {
            var productExist = products.FirstOrDefault(x => x.Id == product.Id);
            if (productExist == null)
            {
                throw new Exception($"El producto {product.Name} no se encuentra registrado en el sistema.");
            }
            else
            {
                productExist.Name = string.IsNullOrEmpty(product.Name) ? productExist.Name : product.Name;
                productExist.Description = string.IsNullOrEmpty(product.Description) ? productExist.Description : product.Description;
                productExist.Price = product.Price == 0 ? productExist.Price : product.Price;
                productExist.Category = string.IsNullOrEmpty(product.Category) ? productExist.Category : product.Category;

                return productExist;
            }
        }

        [HttpPost]
        [Route("DeleteProduct")]
        public ActionResult<Product> DeleteProduct([FromHeader] int id)
        {
            var productExist = products.FirstOrDefault(x => x.Id == id);
            if (productExist == null)
            {
                throw new Exception($"El producto no se encuentra registrado en el sistema.");
            }
            else
            {

                products.Remove(productExist);
                return Ok(new { message = $"El producto con Id {id} fue eliminado correctamente." });
            }
        }
    }
}
