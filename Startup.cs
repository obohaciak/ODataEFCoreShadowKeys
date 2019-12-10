using System.Linq;

using Microsoft.AspNet.OData.Builder;
using Microsoft.AspNet.OData.Extensions;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.OData.Edm;

namespace ODataEFCoreShadowKeys
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }
        
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc(options =>
            {
                options.EnableEndpointRouting = false;
            }).SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

            services.AddOData();

            services.AddDbContext<ODataEFCoreShadowKeysContext>();
        }

        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {            
            var builder = new ODataConventionModelBuilder(app.ApplicationServices);
            builder.EntitySet<Pet>("Pets");
            IEdmModel model = builder.GetEdmModel();

            app.UseMvc(routeBuilder =>
            {                
                routeBuilder.Select().Expand().Filter().OrderBy().MaxTop(100).Count();

                routeBuilder.MapODataServiceRoute("ODataRoute", "odata", model);                
            });
        }
    }
}