using Microsoft.AspNetCore.Mvc;
using System;
using T2TiERPFenix.Models;
using T2TiERPFenix.Repository;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;

namespace T2TiERPFenix.Controllers
{
    [Route("banco")]
    [Produces("application/json")]
    public class BancoController : Controller
    {
        private IRepositoryWrapper _repository;

        public BancoController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaBanco([FromQuery]string filter)
        {
            try
            {
                IEnumerable<Banco> lista;
                if (filter == null)
                {
                    lista = _repository.Banco.ConsultarLista();
                } else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.Banco.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista Banco]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoBanco")]
        public IActionResult ConsultarObjetoBanco(int id)
        {
            try
            {
                var objeto = _repository.Banco.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto Banco]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto Banco]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirBanco([FromBody]Banco objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir Banco]", null));
                }

                _repository.Banco.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoBanco", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir Banco]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarBanco([FromBody]Banco objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Banco]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Banco] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.Banco.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar Banco]", null));
                }

                _repository.Banco.Alterar(objBanco, objJson);

                return ConsultarObjetoBanco(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar Banco]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirBanco(int id)
        {
            try
            {
                var objeto = _repository.Banco.ConsultarObjeto(id);

                _repository.Banco.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir Banco]", ex));
            }
        }

    }
}