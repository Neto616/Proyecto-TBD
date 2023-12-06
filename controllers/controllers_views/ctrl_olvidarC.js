const con = {
    contraseña: async(req, res) =>{
        try {
            res.render('olvidar-contrasena')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = con
