namespace T2TiRetaguardaSH.Models
{
    public class ObjetoPagSeguro
    {
        public ObjetoPagSeguro() { }

		public string CodigoTransacao { get; set; }
		public string StatusTransacao { get; set; }
		public string CodigoStatusTransacao { get; set; }
		public string EmailCliente { get; set; }
		public string MetodoPagamento { get; set; }
		public string CodigoTipoPagamento { get; set; }
		public string CodigoProduto { get; set; }
		public string DescricaoProduto { get; set; }
		public System.Nullable<System.Decimal> ValorUnitario { get; set; }
	}
}
