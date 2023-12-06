const Nueva_sede = {
    sedeN: async(req, res) =>{
        try {
            res.render('agregar-sede')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = Nueva_sede
