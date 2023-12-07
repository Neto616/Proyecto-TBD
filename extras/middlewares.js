const mdwSesion = async (req, res, next) => {
    if(req.session.sesion){
        next();
    }else{
        res.redirect('/');
    }
}
const mdwAdmin = async (req, res, next) =>{
    if(req.session.sesion.rol === "Admin"){
        next();
    }else{
        res.redirect('/');
    }
}

const mdwInstituto = async(req, res, next) => {
    if(req.session.sesion.rol === "Instituto"){
        next();
    }else{
        res.redirect('/');
    }
}

const mdwAsesor = async (req, res, next) => {
    if(req.session.sesion.rol === "Asesor"){
        next();
    }else{
        res.redirect('/');
    }
}

const mdwJuez = async (req, res, next) => {
    if(req.session.sesion.rol === "Juez"){
        next();
    }else{
        res.redirect('/');
    }
}

module.exports = {
    mdwSesion,
    mdwAdmin,
    mdwAsesor,
    mdwInstituto,
    mdwJuez,
}