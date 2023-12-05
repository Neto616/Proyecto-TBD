const mdwSesion = async (req, res, next) => {
    if(req.session.usuario){
        next();
    }else{
        res.redirect('/');
    }
}
const mdwAdmin = async (req, res, next) =>{
    if(req.session.usuario.rol === "Admin"){
        next();
    }else{
        res.redirect('/');
    }
}

const mdwInstituto = async(req, res, next) => {
    if(req.session.usuario.rol === "Instituto"){
        next();
    }else{
        res.redirect('/');
    }
}

const mdwAsesor = async (req, res, next) => {
    if(req.session.usuario.rol === "Asesor"){
        next();
    }else{
        res.redirect('/');
    }
}

const mdwJuez = async (req, res, next) => {
    if(req.session.usuario.rol === "Juez"){
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