using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Nanjing.Startup))]
namespace Nanjing
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
