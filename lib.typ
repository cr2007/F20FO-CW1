#let template(doc) = [
  #let data = yaml("metadata.yml")
  
  #set page(
    footer: [
      #h(1fr)
      #context counter(page).display("1")
      #h(1fr)
    ],
  )

  #set text(font: "Segoe UI")

  #set align(center)

  #show link: underline

  #show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    text(it)
  }

  #show table.cell.where(fill: rgb("#262626")): it => {
    strong(text(fill: rgb("#FFFFFF"), it))
  }

  #doc
]
