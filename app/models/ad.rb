class Ad < Sequel::Model
  def validate
    super
    validates_presence :city, message: I18n.t(:blank, scope: 'models.errors.ad.city')
    validates_presence :title, message: I18n.t(:blank, scope: 'models.errors.ad.title')
    validates_presence :description, message: I18n.t(:blank, scope: 'models.errors.ad.description')
  end
end
