public class Cliente extends Pessoa {
    private final Endereco endereco;
    private final String telefone; 

    public Cliente(Endereco endereco, String telefone) {
        this.endereco = endereco;
        this.telefone = telefone;
    }
}