
CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = ENV["TYBurzNuy6Rok1mdl9Q63AJyPxDcPK7FEA4MWurB"]
  config.qiniu_secret_key    = ENV["Q81jNwVOIgLlHBeIWHhMib9BtBR4F5gA-udUa-pz"]
  config.qiniu_bucket        = ENV["jdstore"]
  config.qiniu_bucket_domain = ENV["oqgnjaxh1.bkt.clouddn.com"]
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"
  config.qiniu_up_host       = "http://up.qiniug.com"  #选择不同的区域时，"up.qiniug.com" 不同

end
