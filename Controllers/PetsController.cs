using System.Linq;

using Microsoft.AspNet.OData;

namespace ODataEFCoreShadowKeys
{
    public class PetsController
    {
        private ODataEFCoreShadowKeysContext db;

        public PetsController(ODataEFCoreShadowKeysContext db)
        {
            this.db = db;
        }

        [EnableQuery]
        public IQueryable<Pet> Get(ODataEFCoreShadowKeysContext db)
        {            
            return db.Pet;
        }
    }
}