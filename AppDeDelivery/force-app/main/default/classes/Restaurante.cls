public class Restaurante {
    private String nome;
    private String endereco;
    CategoriaRestaurante categoria; //atributo do tipo enum
    private List<Produto> cardapio;

    public Restaurante (String nome, String endereco, CategoriaRestaurante categoria, List<Produto> categoria ){
        this.nome = nome;
        this.endereco = endereco;
        this.categoria = categoria;
        this.cardapio = cardapio;
    }

    // O Getter retorna uma das opções do Enum
    public CategoriaRestaurante getCategoria() {
        return categoria;
    }

    // O Setter exige que escolha uma das opções do Enum
    public void setCategoria(CategoriaRestaurante categoria) {
        this.categoria = categoria;
    }

    //metodos------------------------------
}