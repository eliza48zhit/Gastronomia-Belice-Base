// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaBelice
 * @dev Registro historico con Likes, Dislikes e Identificador de Acompanamiento (Base).
 */
contract GastronomiaBelice {

    struct Plato {
        string nombre;
        string descripcion;
        string baseCarbohidrato; // Ej: Rice and Beans, Coconut Husk, Cassava
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con el plato nacional de Belice
        registrarPlato(
            "Rice and Beans", 
            "Arroz y frijoles rojos cocinados con leche de coco y especias del Caribe.",
            "Coconut Rice"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _baseCarbohidrato
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre,
            descripcion: _descripcion,
            baseCarbohidrato: _baseCarbohidrato,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory baseCarbohidrato,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.baseCarbohidrato, p.likes, p.dislikes);
    }
}
