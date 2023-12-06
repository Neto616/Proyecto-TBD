const equipo = {
    eque: async(req, res) =>{
        try {
            res.render('agregar-equipo')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = equipo