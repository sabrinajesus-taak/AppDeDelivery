public class Produto extends EntidadeBase{
    public String nome;
    public Dinheiro preco;

    public Produto (String nome, Dinheiro preco) {
        this.nome = nome;
        this.preco = preco;
    }

    public String getNome() {return this.nome; }
    public Dinheiro getPreco() {return this.preco; }
    
}