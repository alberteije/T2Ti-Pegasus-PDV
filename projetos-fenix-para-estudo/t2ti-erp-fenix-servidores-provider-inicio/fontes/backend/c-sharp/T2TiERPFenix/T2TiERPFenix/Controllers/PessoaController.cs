using Microsoft.AspNetCore.Mvc;
using System;
using T2TiERPFenix.Models;
using T2TiERPFenix.Repository;

namespace T2TiERPFenix.Controllers
{
    [Route("pessoa")]
    public class PessoaController : Controller
    {
        private IRepositoryWrapper _repository;

        public PessoaController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaPessoa()
        {
            try
            {
                var listaPessoa = _repository.Pessoa.ConsultarLista();
                return Ok(listaPessoa);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Erro Interno do Servidor [ConsultarListaPessoa] - Exceção: " + ex.Message);
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoPessoa")]
        public IActionResult ConsultarObjetoPessoa(int id)
        {
            try
            {
                var pessoa = _repository.Pessoa.ConsultarObjeto(id);

                if (pessoa == null)
                {
                    return NotFound();
                }
                else
                {
                    return Ok(pessoa);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Erro Interno do Servidor [ConsultarObjetoPessoa] - Exceção: " + ex.Message);
            }
        }

        [HttpPost]
        public IActionResult InserirPessoa([FromBody]Pessoa pessoa)
        {
            try
            {
                if (pessoa == null)
                {
                    return BadRequest("Objeto Pessoa tem é nulo");
                }

                if (!ModelState.IsValid)
                {
                    return BadRequest("Objeto de modelo inválido");
                }

                //pessoa.PessoaJuridica.IdPessoa = 1;
                //if (pessoa.PessoaJuridica.Id > 0)
                //{
                //    _repository.PessoaJuridica.Alterar(pessoa.PessoaJuridica);
                //} else
                //{
                //    _repository.PessoaJuridica.Inserir(pessoa.PessoaJuridica);
                //}

                if (pessoa.ListaContatos.Count > 0)
                {
                    foreach (PessoaContato contato in pessoa.ListaContatos)
                    {
                        contato.IdPessoa = 1;
                        if (contato.Id > 0)
                        {
                            _repository.PessoaContato.Alterar(contato);
                        }
                        else
                        {
                            _repository.PessoaContato.Inserir(contato);
                        }
                    }
                }

                _repository.Pessoa.Inserir(pessoa);

                return CreatedAtRoute("ConsultarObjetoPessoa", new { id = pessoa.Id }, pessoa);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Erro Interno do Servidor [InserirPessoa] - Exceção: " + ex.Message);
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarPessoa(int id, [FromBody]Pessoa pessoa)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest("Objeto de modelo inválido");
                }

                var dbPessoa = _repository.Pessoa.ConsultarObjeto(id);

                _repository.Pessoa.Alterar(dbPessoa, pessoa);

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Erro Interno do Servidor [AlterarPessoa] - Exceção: " + ex.Message);
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirPessoa(int id)
        {
            try
            {
                var pessoa = _repository.Pessoa.ConsultarObjeto(id);

                _repository.Pessoa.Excluir(pessoa);

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Erro Interno do Servidor [ExcluirPessoa] - Exceção: " + ex.Message);
            }
        }

    }
}
