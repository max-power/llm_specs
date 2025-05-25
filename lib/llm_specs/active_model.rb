#require "activesupport/lib/active_support/core_ext/class/attribute"
module LLMSpecs
  def self.use_relative_model_naming? = true

  class Model
    module ActiveModelCompliance
      def persisted? = false
      def errors     = Hash.new { |h,k| h[k] = [] }
      def to_model   = self
      def to_key     = nil
      def to_param   = nil
      def to_partial_path = "models/model"
    end
    
    extend  ActiveModel::Naming
    include ActiveModelCompliance
  end
end
