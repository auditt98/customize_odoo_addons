from odoo import api, fields, models

class DipTangQua(models.Model):
    _name = "product.diptangqua"
    _description = "Dịp tặng quà"
    name = fields.Char(string='Tên dịp tặng quà', store='True', required=True)