// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
 
contract estudiante{
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
 
    mapping (string => uint) private notas_materias;
      
    string [] private materias;

    constructor(string memory nombre_, string memory apellido_, string memory curso_)
    {
 
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
 
    }
 
 
    function apellido() public view returns (string memory){
        // devuelve el apellido del estudiante como string.
        return  _apellido;
    }
    function nombre_completo() public view returns (string memory) {
        // devuelve el nombre y el apellido del estudiante como string.
        // return  _nombre;
        // return  _apellido;
        return string(abi.encodePacked(_nombre, " ",_apellido));
    }  
       

    function curso() public view returns (string memory) {
        // devuelve el curso del alumno como string.
        return  _curso;
    }
        
    function set_nota_materias(string memory materia, uint t) public{
        // asigna el valor notas_materias a nota donde la key es la materia.
        // La nota se recibe como un entero del 1 al 100.
        // Atención, solo el docente registrado puede llamar a esta función.
        require(msg.sender == _docente, "Solo el docente puede ver esto");
        notas_materias[materia] = t;
           
        //del promedio. Manda la nota al array
        materias.push(materia);
 
    }
        
    function nota_materia(string memory materia) public view returns (uint){
        // devuelve la nota del Estudiante dada una materia.
        return  notas_materias[materia];
    }
        
    function aprobo(string memory materia) public view returns (bool){
        // devuelve True si solo si el alumno está aprobado en la materia.
        // La materia se aprueba con 6/10 o más.
        if(notas_materias[materia]<60){
            return false;
        }
        else{
            return true;
        }
    }
        
    function promedio() public view returns (uint) {
        // devuelve un entero con el promedio del alumno.
        uint total;
        uint promediol;

        for(uint i = 0; i < materias.length; i++){
            total += notas_materias[materias[i]];
        }
           
        promediol = total/materias.length;
        return promediol;
    }
}
