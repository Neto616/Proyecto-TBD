const equip = {
    equq: async(req, res) =>{
        try {
            res.render('actualizar-equipo')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = equip