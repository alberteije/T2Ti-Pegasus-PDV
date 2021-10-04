using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using T2TiERPFenix.Models;
using T2TiERPFenix.Repository;

namespace T2TiERPFenix.Controllers
{
    [Route("banco-agencia")]
    [Produces("application/json")]
    public class BancoAgenciaController : Controller
    {
        private IRepositoryWrapper _repository;

        public BancoAgenciaController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaBancoAgencia([FromQuery]string filter)
        {
            try
            {
                IEnumerable<BancoAgencia> lista;
                if (filter == null)
                {
                    lista = _repository.BancoAgencia.ConsultarLista();
                } else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.BancoAgencia.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista Banco Agencia]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoBancoAgencia")]
        public IActionResult ConsultarObjetoBancoAgencia(int id)
        {
            try
            {
                var objeto = _repository.BancoAgencia.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto Banco Agencia]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto Banco Agencia]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirBancoAgencia([FromBody]BancoAgencia objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir Banco Agencia]", null));
                }

                objJson.IdBanco = objJson.Banco.Id;
                _repository.BancoAgencia.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoBancoAgencia", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir Banco Agencia]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarBancoAgencia([FromBody]BancoAgencia objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Banco Agencia]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Banco Agencia] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.BancoAgencia.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar Banco Agencia]", null));
                }

                _repository.BancoAgencia.Alterar(objBanco, objJson);

                return ConsultarObjetoBancoAgencia(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar Banco Agencia]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirBancoAgencia(int id)
        {
            try
            {
                var objeto = _repository.BancoAgencia.ConsultarObjeto(id);

                _repository.BancoAgencia.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir Banco Agencia]", ex));
            }
        }

    }
}