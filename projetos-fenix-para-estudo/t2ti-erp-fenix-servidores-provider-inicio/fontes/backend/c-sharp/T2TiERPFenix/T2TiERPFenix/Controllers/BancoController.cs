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
                IEnumerable<Banco> listaBanco;
                if (filter == null)
                {
                    listaBanco = _repository.Banco.ConsultarLista();
                } else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    listaBanco = _repository.Banco.ConsultarListaFiltro(filtro);
                }
                return Ok(listaBanco);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista Banco]", ex));
            }
        }

        //[HttpGet("{campo}/{valor}")]
        //public IActionResult ConsultarListaBancoFiltroValor(String campo, String valor)
        //{
        //    try
        //    {
        //        // define o filtro
        //        Filtro filtro = new Filtro();
        //        filtro.Campo = campo;
        //        filtro.Valor = valor;

        //        var listaBanco = _repository.Banco.ConsultarListaFiltro(filtro);

        //        return Ok(listaBanco);
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Lista Banco Filtro Padrão]", ex));
        //    }
        //}

        [HttpGet("{id}", Name = "ConsultarObjetoBanco")]
        public IActionResult ConsultarObjetoBanco(int id)
        {
            try
            {
                var banco = _repository.Banco.ConsultarObjeto(id);

                if (banco == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto Banco]", null));
                }
                else
                {
                    return Ok(banco);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto Banco]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirBanco([FromBody]Banco banco)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir Banco]", null));
                }

                _repository.Banco.Inserir(banco);

                return CreatedAtRoute("ConsultarObjetoBanco", new { id = banco.Id }, banco);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir Banco]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarBanco([FromBody]Banco banco, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Banco]", null));
                }

                if (banco.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Banco] - ID do objeto difere do ID da URL.", null));
                }

                var dbBanco = _repository.Banco.ConsultarObjeto(banco.Id);

                if (dbBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar Banco]", null));
                }

                _repository.Banco.Alterar(dbBanco, banco);

                return Ok(banco);
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
                var banco = _repository.Banco.ConsultarObjeto(id);

                _repository.Banco.Excluir(banco);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir Banco]", ex));
            }
        }

    }
}