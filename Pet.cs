namespace ODataEFCoreShadowKeys
{
    public partial class Pet
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public virtual Person Owner { get; set; }
    }
}