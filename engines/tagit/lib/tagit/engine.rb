require 'acts-as-taggable-on'

module Tagit
  class Engine < ::Rails::Engine
    isolate_namespace Tagit
    
    class << self
       def ids_tagged_with(tag,type)
         tag = ActsAsTaggableOn::Tag.where(:name => tag).first
         taggings = ActsAsTaggableOn::Tagging.where(:taggable_type => type, :tag => tag).all
         taggings.map(&:taggable_id)
       end
       
       def get_tags(id,type)
           taggings = ActsAsTaggableOn::Tagging.where(:taggable_type => type.to_s, :taggable_id => id)
           taggings.map(&:tag).to_a.uniq
       end
       
       def tag(tagger_id, tagger_type, taggable_id, taggable_type, tag)
            tag = ActsAsTaggableOn::Tag.where(:name => tag).first_or_create     
            tagging = ActsAsTaggableOn::Tagging.create(:tagger_id => tagger_id, 
                      :tagger_type => tagger_type.to_s,
                      :taggable_id => taggable_id,
                      :taggable_type => taggable_type.to_s,
                      :tag => tag , :context => "tags")
       end
    end
  end
end
