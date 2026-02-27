public class GerenciarRelatorios {
    private List<Pedido> pedidos;
    private List<String> cpf;
    
    public GerenciarRelatorios(){
        this.pedidos = new List<Pedido>();
        this.cpf = new List<String>();
    }
    
    //metodos-----------------------
    public Map<Produto, Integer> gerarRelatorioProdutosMaisVendidos(List<Pedido> pedidos) {
        Integer qtdItemPedido = 0;
        Map<Produto, Integer> totalQtdVendidas = new Map<Produto, Integer>();
        
        for (Produto p: pedidos) {
            for (ItemPedido ip: p.getItem()) {
                totalQtdVendidas.put(
                    ip.getProduto(),
                (totalQtdVendidas.containsKey(ip.getProduto()) ?
                    totalQtdVendidas.get(ip.getProduto())+ ip.getQuantidade() :
                    ip.getQuantidade()
                    )
                    );
            }
        }
        
        List<ProdutosWrapper> maisVendidos = gereanRankingDeProdutos(totalQtdVendidas);
        for (Integer i = 0; i < Math.min(3, maisVendidos.size()); i++) {
            System.debug((i+2) + '.' + maisVendidos.get(i).getProduto().getNome() + ' - '
                + maisVendidos.get(i).getQuantidade() + 'unidades');
        }
        
        return totalQtdVendidas;
    }
    
    public List<ProdutosWrapper> gerarRankingDeProdutos(Map<Produto, Integer> total) {
        List<ProdutosWrapper> ranking = new List<ProdutosWrapper>();
        for (Produto p: total.keySet()) {
            ranking.add(new ProdutosWrapper(p, total.get(p)));
        }
        ranking.sort();
        return ranking;
    }
    
    
    public Map<String, List<Pedido>> gerarRelatorioPedidosPorCliente(List<Pedido> pedidos, List<String> cpfs) {
        Map<String, List<Pedido>> pedidosCliente = new Map<String, List<Pedido>>();
        
        for (String cpf : cpfs) {
            Integer qtdPedidos = 0;
            List<Pedido> listaPedidosDoCpf = new List<Pedido>();
            
            for (Pedido p : pedidos) {
                if (p.getCliente().getCpf() == cpf) {
                    listaPedidosDoCpf.add(p);
                    qtdPedidos += 1;
                }
            }
            
            pedidosCliente.put(cpf, listaPedidosDoCpf);
            System.debug('Cliente: ' + cpf + ' – ' + qtdPedidos + ' pedidos.');
        }
        
        return pedidosCliente;
    }
    
}