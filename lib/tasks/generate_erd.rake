desc 'Generate Entity Relationship Diagram'
task :generate_erd do
  system 'bundle exec erd --inheritance --filetype=dot --notation=bachman --direct --attributes=foreign_keys,content'
  system 'dot -Tpng erd.dot > erd.png'
  File.delete('erd.dot')
end