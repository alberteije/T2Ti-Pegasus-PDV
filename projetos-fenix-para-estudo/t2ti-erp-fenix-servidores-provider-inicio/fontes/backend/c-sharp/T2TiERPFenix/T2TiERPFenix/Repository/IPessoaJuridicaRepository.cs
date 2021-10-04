using System.Collections.Generic;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public interface IPessoaJuridicaRepository : IRepositoryBase<PessoaJuridica>
    {
        IEnumerable<PessoaJuridica> ConsultarLista();
        PessoaJuridica ConsultarObjeto(int pessoaJuridicaId);
        void Inserir(PessoaJuridica pessoaJuridica);
        void Alterar(PessoaJuridica pessoaJuridica);
        void Excluir(PessoaJuridica pessoaJuridica);
    }
}
