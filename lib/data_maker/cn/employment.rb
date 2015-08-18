module DataMaker
  module CN
    module Employment
      extend ModuleUtilities

      def self.job_title
        job_title = JOB_TITLES.sample.downcase.split(" ").join("_")
        DataMaker::Config.locale = :zh
        DataMaker.translate(['data_maker', 'employment', 'job_titles', job_title].join("."))
      end
    end
  end
end
