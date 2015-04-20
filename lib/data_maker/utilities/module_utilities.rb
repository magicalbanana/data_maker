require 'data_maker/utilities/array_utilities'

module DataMaker
  module ModuleUtilities
    def k(arg)
      DataMaker::ArrayUtilities.const_array(arg)
    end

    def const_missing(const_name)
      if const_name =~ /[a-z]/ # Not a constant, probably a class/module name.
        super const_name
      else
        locale = ancestors.first.to_s.split("::")[-2]
        mod_name = ancestors.first.to_s.split("::").last
        data_path = "#{DataMaker::BASE_LIB_PATH}/data_maker/data/#{underscore(locale)}/#{underscore(mod_name)}/#{underscore(const_name.to_s)}"
        data = k File.read(data_path).split("\n")
        const_set const_name, data
        data
      end
    end

    def underscore(string)
      string.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end
  end
end
