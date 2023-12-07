const Agr_Alunmo = {
    alun: async(req, res) => {
        try {
            res.render('agregar-alunmo')
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    }
}

module.exports = Agr_Alunmo