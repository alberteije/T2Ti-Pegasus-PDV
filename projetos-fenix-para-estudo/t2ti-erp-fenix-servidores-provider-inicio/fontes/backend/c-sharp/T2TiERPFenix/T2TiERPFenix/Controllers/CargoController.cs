using Microsoft.AspNetCore.Mvc;
using System;
using T2TiERPFenix.Models;
using T2TiERPFenix.Repository;

namespace T2TiERPFenix.Controllers
{
    [Route("cargo")]
    public class CargoController : Controller
    {
        private IRepositoryWrapper _repository;

        public CargoController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaCargo()
        {
            try
            {
                var listaCargo = _repository.Cargo.ConsultarLista();
                return Ok(listaCargo);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Erro Interno do Servidor [ConsultarListaCargo] - Exceção: " + ex.Message);
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoCargo")]
        public IActionResult ConsultarObjetoCargo(int id)
        {
            try
            {
                var cargo = _repository.Cargo.ConsultarObjeto(id);

                if (cargo == null)
                {
                    return NotFound();
                }
                else
                {
                    return Ok(cargo);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Erro Interno do Servidor [ConsultarObjetoCargo] - Exceção: " + ex.Message);
            }
        }

        [HttpPost]
        public IActionResult InserirCargo([FromBody]Cargo cargo)
        {
            try
            {
                if (cargo == null)
                {
                    return BadRequest("Objeto Cargo tem é nulo");
                }

                if (!ModelState.IsValid)
                {
                    return BadRequest("Objeto de modelo inválido");
                }

                _repository.Cargo.Inserir(cargo);

                return CreatedAtRoute("ConsultarObjetoCargo", new { id = cargo.Id }, cargo);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Erro Interno do Servidor [InserirCargo] - Exceção: " + ex.Message);
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarCargo(int id, [FromBody]Cargo cargo)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest("Objeto de modelo inválido");
                }

                var dbCargo = _repository.Cargo.ConsultarObjeto(id);

                _repository.Cargo.Alterar(dbCargo, cargo);

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Erro Interno do Servidor [AlterarCargo] - Exceção: " + ex.Message);
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirCargo(int id)
        {
            try
            {
                var cargo = _repository.Cargo.ConsultarObjeto(id);

                _repository.Cargo.Excluir(cargo);

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Erro Interno do Servidor [ExcluirCargo] - Exceção: " + ex.Message);
            }
        }

    }
}
