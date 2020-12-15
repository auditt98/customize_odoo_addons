from odoo import api, fields, models

class DoiTuongTang(models.Model):
    _name = "product.doituongtang"
    _description = "Quà tặng cho đối tượng nào"
    name = fields.Char(string='Quà tặng cho người thân', required=True)