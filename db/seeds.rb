# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


statuses = [
  { name: 'Planejado', color: "666666" },
  { name: 'Em execução', color: "0000ff" },
  { name: 'Concluído com sucesso', color: "00ff00" },
  { name: 'Aguardando coleta', color: "aaff00" },
  { name: 'Falha na coleta', color: "ff0000" },
  { name: 'Erro na aplicação', color: "ff0000" },
]

statuses.each do |status|
  Status.find_or_create_by(name: status[:name]) do |s|
    s.color = status[:color]
  end
end



applications = [
    {name: "Coletor IGMA"},
    {name: "Data Aquila"},
    {name: "Fabrica Virtual"},
    {name: "Intranet"}
]

applications.each do |app|
    Application.find_or_create_by(name: app[:name])
end