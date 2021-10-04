using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using T2TiERPFenix.Models;
using T2TiERPFenix.Repository;

namespace T2TiERPFenix.Controllers
{
    [Route("pessoa")]
    [Produces("application/json")]
    public class PessoaController : Controller
    {
        private IRepositoryWrapper _repository;

        public PessoaController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaPessoa([FromQuery]string filter)
        {
            try
            {
                IEnumerable<Pessoa> lista;
                if (filter == null)
                {
                    lista = _repository.Pessoa.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.Pessoa.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista Pessoa]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoPessoa")]
        public IActionResult ConsultarObjetoPessoa(int id)
        {
            try
            {
                var objeto = _repository.Pessoa.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto Pessoa]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto Pessoa]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirPessoa([FromBody]Pessoa objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir Pessoa]", null));
                }
                _repository.Pessoa.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoPessoa", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir Pessoa]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarPessoa([FromBody]Pessoa objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Pessoa]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Pessoa] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.Pessoa.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar Pessoa]", null));
                }

                _repository.Pessoa.Alterar(objBanco, objJson);

                return ConsultarObjetoPessoa(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar Pessoa]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirPessoa(int id)
        {
            try
            {
                var objeto = _repository.Pessoa.ConsultarObjeto(id);

                _repository.Pessoa.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir Pessoa]", ex));
            }
        }

    }
}