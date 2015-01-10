class UpdateRisksInProduct


  def initialize(risk_products_params, product)
    @risk_products_params = risk_products_params
    @product = product
    @result = Result.new(false)
    # @error_string = ''
  end

  def generate_models
    error_string = ''
    @risk_products = []
    counter = 0
    result = true
    @risk_products_params.each do |key, value|
      begin
        risk_product = value[:id].blank? ? prepare_new_risk_product : RiskProduct.find(value[:id])
        @risk_products[counter] = risk_product
      rescue
        @risk_products[counter] = nil
        error_string += 'nie znaleziono risk_product'
        result = false
      end
      value[:risk_attributes].each do |field_name, field_value|
        if field_name=='id' and @risk_products[counter].risk.id.blank? # replace builded risk because risk exist
          begin
            @risk_products[counter].risk = find_and_fill_risk(counter, field_value) unless @risk_products[counter].blank?
          rescue
            @risk_products[counter].risk = nil
            error_string += 'nie znaleziono takiego ryzyka, '
            result = false
          end
        end
        update_risk_by_form_fields(counter, field_name, field_value)
      end
      counter += 1
    end
    begin
      save_risks
    rescue
      error_string += 'nie mogłem zapisać risk_product lub risk, '
      result = false
    end
    @result.result = result
    @result.error_string = error_string
    @result
  end

  # def error_string
  #   @error_string
  # end

  #############################################################################################################
  private

  def prepare_new_risk_product
    risk_product = RiskProduct.new
    risk_product.product = @product
    risk_product.build_risk
    risk_product
  end

  def find_and_fill_risk(counter, risk_id)
    risk = Risk.find(risk_id)
    # żeby zachować już wcześniej w pętli znalezione dane z pól
    risk.code = @risk_products[counter].risk.code unless @risk_products[counter].risk.code.blank?
    risk.name = @risk_products[counter].risk.name unless @risk_products[counter].risk.name.blank?
    risk.incl_excl = @risk_products[counter].risk.incl_excl unless @risk_products[counter].risk.incl_excl.blank?
    risk
  end

  def update_risk_by_form_fields(counter, field_name, field_value)
    @risk_products[counter].risk.code = field_value if field_name=='code'
    @risk_products[counter].risk.name = field_value if field_name=='name'
    @risk_products[counter].risk.incl_excl = field_value if field_name=='incl_excl'
  end

  def save_risks
    @risk_products.each { |risk_product| risk_product.save! }
  end

end