const Agr_asesor = {
    ase: async(req, res) =>{
        try {
            res.render('agregar-asesor')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = Agr_asesor