module HashImporters
  class PlansHashImporter < Base
    def self.import(hash, opts = {})
      import_each(hash, :missions, MissionHashImporter, opts)
      import_each(hash, :visions, VisionHashImporter, opts)
      import_each(hash, :csfs, CsfHashImporter, opts)
      spheres = import_each(
        hash, :spheres, SphereHashImporter, opts
      )
      import_each(
        hash, :plans, PlanHashImporter, opts.merge(spheres: spheres)
      )
    end
  end
end
