public class PoliticaPrecoPromocionalPorHorario implements PoliticaDePreco {
    private Integer horaInicio;
    private Integer horaFim;
    private Decimal desconto;
    
    public PoliticaPrecoPromocionalPorHorario (Integer horaInicio, Integer horaFim, Decimal desconto) {
        this.horaInicio = horaInicio;
        this.horaFim = horaFim;
        this.desconto = desconto;
    }
    
    public Dinheiro calcularPreco(Produto produto){
        Integer horaAtual = Datetime.now().hour();
        
        if (horaAtual >= horaInicio && horaAtual <= horaFim) {
            return produto.getPrecoBase().subtrair(produto.getPrecoBase().multiplicar(this.desconto / 100.0));
        }
        return produto.getPrecoBase();
    }
}