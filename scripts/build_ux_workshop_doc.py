from pathlib import Path

from docx import Document
from docx.enum.section import WD_SECTION
from docx.enum.table import WD_ALIGN_VERTICAL, WD_TABLE_ALIGNMENT
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_BREAK, WD_LINE_SPACING
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import Inches, Pt, RGBColor


OUTPUT = Path("docs/atelier-ux-gestionnaires-cash-alimentaire.docx")

BROWN = "6B5353"
DARK = "302828"
CREAM = "F5EFE8"
SAGE = "DDE5DA"
GOLD = "B99A5B"
LIGHT = "F6F6F6"
MID = "D9D2CC"
WHITE = "FFFFFF"
MUTED = "686363"

PAGE_WIDTH_DXA = 12240
PAGE_HEIGHT_DXA = 15840
CONTENT_WIDTH_DXA = 9360
TABLE_INDENT_DXA = 120


def rgb(value):
    return RGBColor.from_string(value)


def set_cell_fill(cell, fill):
    tc_pr = cell._tc.get_or_add_tcPr()
    shd = tc_pr.find(qn("w:shd"))
    if shd is None:
        shd = OxmlElement("w:shd")
        tc_pr.append(shd)
    shd.set(qn("w:fill"), fill)


def set_cell_margins(cell, top=100, start=120, bottom=100, end=120):
    tc = cell._tc
    tc_pr = tc.get_or_add_tcPr()
    tc_mar = tc_pr.first_child_found_in("w:tcMar")
    if tc_mar is None:
        tc_mar = OxmlElement("w:tcMar")
        tc_pr.append(tc_mar)
    for tag, value in (("top", top), ("start", start), ("bottom", bottom), ("end", end)):
        node = tc_mar.find(qn(f"w:{tag}"))
        if node is None:
            node = OxmlElement(f"w:{tag}")
            tc_mar.append(node)
        node.set(qn("w:w"), str(value))
        node.set(qn("w:type"), "dxa")


def set_repeat_table_header(row):
    tr_pr = row._tr.get_or_add_trPr()
    tbl_header = OxmlElement("w:tblHeader")
    tbl_header.set(qn("w:val"), "true")
    tr_pr.append(tbl_header)


def prevent_row_split(row):
    tr_pr = row._tr.get_or_add_trPr()
    cant_split = OxmlElement("w:cantSplit")
    tr_pr.append(cant_split)


def set_table_borders(table, color=MID, size=6):
    tbl_pr = table._tbl.tblPr
    borders = tbl_pr.find(qn("w:tblBorders"))
    if borders is None:
        borders = OxmlElement("w:tblBorders")
        tbl_pr.append(borders)
    for edge in ("top", "left", "bottom", "right", "insideH", "insideV"):
        element = borders.find(qn(f"w:{edge}"))
        if element is None:
            element = OxmlElement(f"w:{edge}")
            borders.append(element)
        element.set(qn("w:val"), "single")
        element.set(qn("w:sz"), str(size))
        element.set(qn("w:space"), "0")
        element.set(qn("w:color"), color)


def set_table_geometry(table, widths, indent=TABLE_INDENT_DXA):
    assert sum(widths) == CONTENT_WIDTH_DXA, (widths, sum(widths))
    table.autofit = False
    table.alignment = WD_TABLE_ALIGNMENT.LEFT
    tbl_pr = table._tbl.tblPr

    tbl_w = tbl_pr.find(qn("w:tblW"))
    if tbl_w is None:
        tbl_w = OxmlElement("w:tblW")
        tbl_pr.append(tbl_w)
    tbl_w.set(qn("w:w"), str(CONTENT_WIDTH_DXA))
    tbl_w.set(qn("w:type"), "dxa")

    tbl_ind = tbl_pr.find(qn("w:tblInd"))
    if tbl_ind is None:
        tbl_ind = OxmlElement("w:tblInd")
        tbl_pr.append(tbl_ind)
    tbl_ind.set(qn("w:w"), str(indent))
    tbl_ind.set(qn("w:type"), "dxa")

    grid = table._tbl.tblGrid
    for child in list(grid):
        grid.remove(child)
    for width in widths:
        col = OxmlElement("w:gridCol")
        col.set(qn("w:w"), str(width))
        grid.append(col)

    for row in table.rows:
        prevent_row_split(row)
        for index, cell in enumerate(row.cells):
            width = widths[index]
            tc_pr = cell._tc.get_or_add_tcPr()
            tc_w = tc_pr.find(qn("w:tcW"))
            if tc_w is None:
                tc_w = OxmlElement("w:tcW")
                tc_pr.append(tc_w)
            tc_w.set(qn("w:w"), str(width))
            tc_w.set(qn("w:type"), "dxa")
            cell.width = Inches(width / 1440)
            cell.vertical_alignment = WD_ALIGN_VERTICAL.CENTER
            set_cell_margins(cell)


def set_run(run, size=10.5, color=DARK, bold=False, italic=False, font="Aptos"):
    run.font.name = font
    run._element.get_or_add_rPr().rFonts.set(qn("w:ascii"), font)
    run._element.get_or_add_rPr().rFonts.set(qn("w:hAnsi"), font)
    run.font.size = Pt(size)
    run.font.color.rgb = rgb(color)
    run.bold = bold
    run.italic = italic


def set_cell_text(cell, text, *, bold=False, color=DARK, size=9.5, align=WD_ALIGN_PARAGRAPH.LEFT):
    cell.text = ""
    p = cell.paragraphs[0]
    p.alignment = align
    p.paragraph_format.space_before = Pt(0)
    p.paragraph_format.space_after = Pt(0)
    p.paragraph_format.line_spacing = 1.12
    set_run(p.add_run(text), size=size, color=color, bold=bold)


def add_para(doc, text="", *, size=10.5, color=DARK, bold=False, italic=False,
             before=0, after=6, align=WD_ALIGN_PARAGRAPH.LEFT, keep=False):
    p = doc.add_paragraph()
    p.alignment = align
    p.paragraph_format.space_before = Pt(before)
    p.paragraph_format.space_after = Pt(after)
    p.paragraph_format.line_spacing = 1.25
    p.paragraph_format.keep_with_next = keep
    set_run(p.add_run(text), size=size, color=color, bold=bold, italic=italic)
    return p


def add_label_line(doc, label, value="", after=5):
    p = doc.add_paragraph()
    p.paragraph_format.space_after = Pt(after)
    p.paragraph_format.line_spacing = 1.15
    set_run(p.add_run(label + " "), size=10, color=BROWN, bold=True)
    set_run(p.add_run(value if value else "________________________________________________________________"), size=10, color=DARK)
    return p


def add_heading(doc, text, level=1):
    p = doc.add_paragraph(style=f"Heading {level}")
    p.paragraph_format.keep_with_next = True
    p.add_run(text)
    return p


def add_kicker(doc, text):
    p = add_para(doc, text.upper(), size=9, color=GOLD, bold=True, after=2, keep=True)
    return p


def add_callout(doc, label, text, fill=CREAM):
    table = doc.add_table(rows=1, cols=1)
    set_table_geometry(table, [CONTENT_WIDTH_DXA])
    set_table_borders(table, color=fill, size=2)
    cell = table.cell(0, 0)
    set_cell_fill(cell, fill)
    set_cell_margins(cell, top=140, bottom=140, start=180, end=180)
    p = cell.paragraphs[0]
    p.paragraph_format.space_after = Pt(2)
    set_run(p.add_run(label + "  "), size=10, color=BROWN, bold=True)
    set_run(p.add_run(text), size=10, color=DARK)
    add_para(doc, "", size=2, after=2)


def add_form_table(doc, headers, rows, widths, *, header_fill=BROWN, blank_rows=0, font_size=9):
    data = list(rows) + [[""] * len(headers) for _ in range(blank_rows)]
    table = doc.add_table(rows=1 + len(data), cols=len(headers))
    set_table_geometry(table, widths)
    set_table_borders(table)
    for index, header in enumerate(headers):
        cell = table.rows[0].cells[index]
        set_cell_fill(cell, header_fill)
        set_cell_text(cell, header, bold=True, color=WHITE, size=font_size)
    set_repeat_table_header(table.rows[0])
    for row_index, values in enumerate(data, start=1):
        for col_index, value in enumerate(values):
            cell = table.rows[row_index].cells[col_index]
            if row_index % 2 == 0 and value:
                set_cell_fill(cell, LIGHT)
            set_cell_text(cell, str(value), size=font_size)
            if not value:
                p = cell.paragraphs[0]
                p.paragraph_format.space_after = Pt(12)
    return table


def add_checkbox_group(doc, prompt, options):
    add_para(doc, prompt, size=10, color=BROWN, bold=True, after=4, keep=True)
    p = doc.add_paragraph()
    p.paragraph_format.space_after = Pt(8)
    p.paragraph_format.line_spacing = 1.4
    for index, option in enumerate(options):
        if index:
            p.add_run("     ")
        set_run(p.add_run(f"[ ] {option}"), size=10, color=DARK)


def add_exercise_header(doc, number, title, duration, deliverable):
    kicker = add_kicker(doc, f"Exercice {number}  |  {duration}")
    kicker.paragraph_format.page_break_before = True
    add_heading(doc, title, 1)
    add_callout(doc, "LIVRABLE ATTENDU", deliverable, fill=SAGE)


def configure_styles(doc):
    normal = doc.styles["Normal"]
    normal.font.name = "Aptos"
    normal._element.rPr.rFonts.set(qn("w:ascii"), "Aptos")
    normal._element.rPr.rFonts.set(qn("w:hAnsi"), "Aptos")
    normal.font.size = Pt(10.5)
    normal.font.color.rgb = rgb(DARK)
    normal.paragraph_format.space_after = Pt(6)
    normal.paragraph_format.line_spacing = 1.25

    for level, size, before, after in ((1, 17, 18, 10), (2, 13.5, 14, 7), (3, 11.5, 10, 5)):
        style = doc.styles[f"Heading {level}"]
        style.font.name = "Aptos Display"
        style._element.rPr.rFonts.set(qn("w:ascii"), "Aptos Display")
        style._element.rPr.rFonts.set(qn("w:hAnsi"), "Aptos Display")
        style.font.size = Pt(size)
        style.font.bold = True
        style.font.color.rgb = rgb(BROWN if level < 3 else DARK)
        style.paragraph_format.space_before = Pt(before)
        style.paragraph_format.space_after = Pt(after)
        style.paragraph_format.keep_with_next = True
        style.paragraph_format.keep_together = True


def configure_page(doc):
    section = doc.sections[0]
    section.page_width = Inches(8.5)
    section.page_height = Inches(11)
    section.top_margin = Inches(0.75)
    section.bottom_margin = Inches(0.75)
    section.left_margin = Inches(1)
    section.right_margin = Inches(1)
    section.header_distance = Inches(0.35)
    section.footer_distance = Inches(0.4)

    header = section.header
    p = header.paragraphs[0]
    p.alignment = WD_ALIGN_PARAGRAPH.RIGHT
    p.paragraph_format.space_after = Pt(0)
    set_run(p.add_run("CASH ALIMENTAIRE  |  ATELIER UX"), size=8, color=MUTED, bold=True)

    footer = section.footer
    p = footer.paragraphs[0]
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_before = Pt(0)
    p.paragraph_format.space_after = Pt(0)
    set_run(p.add_run("Document de travail  •  page "), size=8, color=MUTED)
    page_field = OxmlElement("w:fldSimple")
    page_field.set(qn("w:instr"), "PAGE")
    field_run = OxmlElement("w:r")
    field_props = OxmlElement("w:rPr")
    field_color = OxmlElement("w:color")
    field_color.set(qn("w:val"), MUTED)
    field_size = OxmlElement("w:sz")
    field_size.set(qn("w:val"), "16")
    field_props.append(field_color)
    field_props.append(field_size)
    field_run.append(field_props)
    field_text = OxmlElement("w:t")
    field_text.text = "1"
    field_run.append(field_text)
    page_field.append(field_run)
    p._p.append(page_field)


def build():
    doc = Document()
    configure_styles(doc)
    configure_page(doc)

    # Cover / workshop-agenda header pattern.
    add_para(doc, "ATELIER DE CO-CONCEPTION", size=9.5, color=GOLD, bold=True, after=6)
    add_para(doc, "Construire l’expérience\nCash Alimentaire", size=28, color=BROWN, bold=True, after=8)
    add_para(
        doc,
        "Support de travail pour transformer le site catalogue en outil commercial, éditorial et opérationnel.",
        size=13, color=DARK, after=18,
    )

    metric = doc.add_table(rows=1, cols=4)
    set_table_geometry(metric, [2340, 2340, 2340, 2340], indent=0)
    set_table_borders(metric, color=BROWN, size=5)
    for index, (big, small) in enumerate([
        ("4 h", "atelier"),
        ("6–10", "participants"),
        ("8", "décisions"),
        ("1", "cap commun"),
    ]):
        cell = metric.cell(0, index)
        set_cell_fill(cell, CREAM if index % 2 == 0 else SAGE)
        p = cell.paragraphs[0]
        p.alignment = WD_ALIGN_PARAGRAPH.CENTER
        p.paragraph_format.space_after = Pt(1)
        set_run(p.add_run(big), size=17, color=BROWN, bold=True)
        p2 = cell.add_paragraph()
        p2.alignment = WD_ALIGN_PARAGRAPH.CENTER
        p2.paragraph_format.space_after = Pt(0)
        set_run(p2.add_run(small), size=8.5, color=MUTED, bold=True)

    add_para(doc, "", size=4, after=8)
    add_label_line(doc, "Date :")
    add_label_line(doc, "Lieu :")
    add_label_line(doc, "Facilitateur / facilitatrice :")
    add_label_line(doc, "Participants :", after=12)

    add_callout(
        doc,
        "RÈGLE DU JEU",
        "Nous cherchons des décisions suffisamment précises pour concevoir et gérer le site. Une idée non arbitrée va dans le parking ; une décision retenue reçoit un responsable.",
        fill=CREAM,
    )

    # Instructions and run of show.
    doc.add_page_break()
    add_kicker(doc, "Mode d’emploi")
    add_heading(doc, "Ce que l’atelier doit produire", 1)
    add_para(doc, "À la fin de la séance, l’équipe doit pouvoir remettre au projet huit livrables directement exploitables :")
    add_form_table(
        doc,
        ["#", "Livrable", "Décision obtenue"],
        [
            ["1", "Objectifs et critères de succès", "Ce que le site doit améliorer concrètement"],
            ["2", "Publics prioritaires", "Qui sert-on en premier, et pour quel besoin"],
            ["3", "Architecture de l’offre", "Familles, métiers et services à rendre visibles"],
            ["4", "Promesse et preuves", "Message central et éléments de réassurance"],
            ["5", "Parcours Devenir client", "Étapes, informations demandées et réponse promise"],
            ["6", "Priorités de la page d’accueil", "Ordre et rôle des blocs"],
            ["7", "Matrice éditoriale", "Contenus utiles, fréquence et responsables"],
            ["8", "Gouvernance", "Qui publie, valide, maintient et répond"],
        ],
        [600, 3300, 5460],
        font_size=8.7,
    )

    add_heading(doc, "Déroulé proposé", 2)
    add_form_table(
        doc,
        ["Temps", "Séquence", "Méthode"],
        [
            ["00:00–00:15", "Cadrage", "Objectifs, rôles et règles"],
            ["00:15–00:40", "1. Succès", "Individuel puis convergence"],
            ["00:40–01:05", "2. Publics", "Cartes profils et priorisation"],
            ["01:05–01:30", "3. Offre", "Tri et regroupement"],
            ["01:30–01:55", "4. Promesse", "Écriture et test de crédibilité"],
            ["01:55–02:05", "Pause", "—"],
            ["02:05–02:40", "5. Devenir client", "Cartographie du parcours"],
            ["02:40–03:05", "6. Accueil", "Classement par priorité"],
            ["03:05–03:35", "7. Éditorial", "Matrice contenu / capacité"],
            ["03:35–04:00", "8. Gouvernance et synthèse", "RACI léger et décisions"],
        ],
        [1800, 3000, 4560],
        font_size=8.5,
    )

    doc.add_page_break()
    add_kicker(doc, "Préparer la séance")
    add_heading(doc, "Rôles pendant l’atelier", 1)
    add_form_table(doc, ["Rôle", "Nom", "Responsabilité"], [
        ["Décideur", "", "Arbitre en cas de désaccord"],
        ["Facilitateur", "", "Cadre le temps et reformule"],
        ["Scribe", "", "Consigne les décisions"],
        ["Voix client", "", "Challenge les choix depuis le terrain"],
    ], [2000, 2500, 4860], font_size=8.7)
    add_heading(doc, "Éléments à apporter", 2)
    add_para(doc, "Réunir les éléments existants, même incomplets. L’objectif est de distinguer ce qui est disponible de ce qui devra être produit après l’atelier.")
    add_form_table(doc, ["Élément", "Apporté par", "Disponible ?"], [
        ["Catalogues actuels et dates de validité", "", ""],
        ["Liste des familles et services", "", ""],
        ["Processus actuel de demande commerciale", "", ""],
        ["Questions et objections des prospects", "", ""],
        ["Statistiques ou retours du site actuel", "", ""],
        ["Photographies, logo et documents de marque", "", ""],
    ], [4700, 2860, 1800], font_size=8.5)
    add_checkbox_group(doc, "Matériel conseillé :", ["Post-it", "Feutres", "Gommettes de vote", "Écran", "Chronomètre"])
    add_label_line(doc, "Contrainte ou sujet sensible à connaître avant la séance :")

    # Exercise 1.
    add_exercise_header(doc, "1", "Définir le succès du futur site", "25 min", "Une liste de 3 objectifs prioritaires, chacun associé à un indicateur observable.")
    add_para(doc, "Individuellement, chaque participant formule ce que le site devra avoir changé six mois après sa mise en ligne. Le groupe regroupe ensuite les formulations proches et vote.")
    add_form_table(doc, ["Aujourd’hui, le problème est…", "Dans 6 mois, nous voulons…", "Comment le constater ?"], [], [3100, 3260, 3000], blank_rows=5)
    add_heading(doc, "Vote final", 2)
    add_form_table(doc, ["Priorité", "Objectif retenu", "Indicateur", "Cible / échéance"], [], [1100, 3760, 2500, 2000], blank_rows=3)
    add_checkbox_group(doc, "Le périmètre du site est d’abord :", ["Générer des demandes", "Présenter l’offre", "Diffuser les catalogues", "Renforcer l’image", "Servir les clients existants"])
    add_label_line(doc, "Phrase de succès commune :")
    add_label_line(doc, "", after=2)

    # Exercise 2.
    add_exercise_header(doc, "2", "Choisir les publics prioritaires", "25 min", "Trois publics classés, avec leur besoin principal, leurs objections et l’action attendue.")
    add_callout(doc, "QUESTION", "Si nous ne pouvions satisfaire parfaitement qu’un seul type de professionnel au lancement, lequel choisirions-nous ?", fill=CREAM)
    add_form_table(doc, ["Public / métier", "Situation déclenchante", "Ce qu’il cherche", "Ce qui le freine", "Action attendue"], [], [1650, 1900, 2100, 1900, 1810], blank_rows=5, font_size=8.3)
    add_heading(doc, "Arbitrage", 2)
    add_form_table(doc, ["Rang", "Public retenu", "Pourquoi lui ?", "Connaissance à vérifier"], [], [800, 2300, 3860, 2400], blank_rows=3)
    add_checkbox_group(doc, "Données disponibles pour valider ces choix :", ["Retours commerciaux", "Recherches du site actuel", "Appels entrants", "Données clients", "Aucune donnée consolidée"])
    add_label_line(doc, "Personne chargée de réunir les preuves manquantes :")

    # Exercise 3.
    add_exercise_header(doc, "3", "Rendre l’offre compréhensible", "25 min", "Une double entrée validée : familles de produits et métiers, complétée par les services essentiels.")
    add_para(doc, "Inscrire chaque élément sur une carte, puis regrouper sans reprendre automatiquement l’organisation interne ou celle du fournisseur du thème.")
    add_heading(doc, "Entrée par familles de produits", 2)
    add_form_table(doc, ["Intitulé visible", "Ce que le visiteur y trouvera", "Priorité", "Contenu disponible ?"], [], [2300, 3860, 1200, 2000], blank_rows=7, font_size=8.6)
    doc.add_page_break()
    add_kicker(doc, "Exercice 3  |  suite")
    add_heading(doc, "Entrée par métiers", 2)
    add_form_table(doc, ["Métier", "Besoin spécifique", "Produits / services à montrer", "CTA contextualisé"], [], [1900, 2500, 3160, 1800], blank_rows=6, font_size=8.5)
    add_heading(doc, "Services à rendre visibles", 2)
    add_form_table(doc, ["Service", "Bénéfice client", "Preuve disponible", "Page dédiée ?"], [], [1900, 2900, 2760, 1800], blank_rows=5, font_size=8.5)
    add_label_line(doc, "Éléments hors périmètre du lancement :")

    # Exercise 4.
    add_exercise_header(doc, "4", "Écrire une promesse crédible", "25 min", "Une promesse principale, une sous-promesse et quatre preuves vérifiables.")
    add_callout(doc, "POINT DE DÉPART", "« Le partenaire des métiers de bouche sur la Côte d’Azur. » Cette proposition est une hypothèse à challenger, pas une formulation imposée.", fill=CREAM)
    add_heading(doc, "Test des formulations", 2)
    add_form_table(doc, ["Proposition", "Claire ?", "Différenciante ?", "Crédible ?", "À conserver / corriger"], [], [4000, 1000, 1300, 1100, 1960], blank_rows=4, font_size=8.3)
    add_label_line(doc, "Promesse retenue :")
    add_label_line(doc, "Sous-promesse :")
    add_heading(doc, "Preuves", 2)
    add_form_table(doc, ["Preuve annoncée", "Source / propriétaire", "Date de vérification", "Publier ?"], [], [3300, 2600, 1960, 1500], blank_rows=4, font_size=8.5)
    add_checkbox_group(doc, "La photographie du hero doit montrer en priorité :", ["Un client en situation", "Les équipes Cash", "La livraison", "Les produits", "L’entrepôt"])

    # Exercise 5.
    add_exercise_header(doc, "5", "Concevoir le parcours « Devenir client »", "35 min", "Un parcours court, rassurant et compatible avec le processus commercial réel.")
    add_para(doc, "Commencer par le processus actuel : que se passe-t-il réellement après une demande ? Supprimer ensuite les informations qui ne sont pas nécessaires au premier contact.")
    add_heading(doc, "Parcours réel", 2)
    add_form_table(doc, ["Étape", "Action du prospect", "Action Cash", "Délai réel", "Point de friction"], [], [1000, 2300, 2300, 1400, 2360], blank_rows=6, font_size=8.2)
    doc.add_page_break()
    add_kicker(doc, "Exercice 5  |  suite")
    add_heading(doc, "Formulaire de premier contact", 2)
    add_form_table(doc, ["Information demandée", "Obligatoire ?", "Pourquoi en avons-nous besoin ?", "Peut attendre le rappel ?"], [
        ["Type d’établissement", "", "", ""],
        ["Code postal", "", "", ""],
        ["Entreprise", "", "", ""],
        ["Nom et prénom", "", "", ""],
        ["Téléphone", "", "", ""],
        ["E-mail professionnel", "", "", ""],
        ["Besoin principal", "", "", ""],
        ["Autre :", "", "", ""],
    ], [2400, 1500, 3560, 1900], font_size=8.4)
    add_heading(doc, "Contrat de réponse", 2)
    add_label_line(doc, "Délai de rappel que nous pouvons réellement tenir :")
    add_label_line(doc, "Équipe / personne qui reçoit la demande :")
    add_label_line(doc, "Message affiché après envoi :")
    add_label_line(doc, "Objet de l’e-mail de confirmation :")
    add_checkbox_group(doc, "Réassurances affichées avant le formulaire :", ["Interlocuteur local", "Sans engagement", "Temps de saisie", "Délai de réponse", "Confidentialité"])

    # Exercise 6.
    add_exercise_header(doc, "6", "Hiérarchiser la page d’accueil", "25 min", "Un ordre de lecture partagé et un rôle précis pour chaque bloc.")
    add_para(doc, "Attribuer un rang de 1 à 10. Deux blocs ne peuvent pas avoir le même rang. Tout bloc sans objectif ni contenu maintenable sort de la page.")
    add_form_table(doc, ["Rang", "Bloc", "Question à laquelle il répond", "CTA / suite", "Contenu prêt ?"], [
        ["", "Hero : promesse et CTA", "Pourquoi Cash ?", "Devenir client", ""],
        ["", "Preuves", "Puis-je vous faire confiance ?", "", ""],
        ["", "Familles de produits", "Que proposez-vous ?", "Voir une famille", ""],
        ["", "Entrées métiers", "Comprenez-vous mon activité ?", "Voir mon métier", ""],
        ["", "Catalogues du moment", "Quelles offres puis-je consulter ?", "Feuilleter / télécharger", ""],
        ["", "Services", "Comment allez-vous m’aider ?", "Découvrir les services", ""],
        ["", "Sélection saisonnière", "Qu’est-ce qui est utile maintenant ?", "Voir la sélection", ""],
        ["", "Témoignage / cas client", "Est-ce concret localement ?", "Lire le cas", ""],
        ["", "Conseils", "Que pouvez-vous m’apprendre ?", "Lire les conseils", ""],
        ["", "Bloc Devenir client", "Comment démarrer ?", "Devenir client", ""],
    ], [700, 2300, 2900, 2060, 1400], font_size=7.9)
    add_label_line(doc, "Bloc supprimé ou reporté :")
    add_label_line(doc, "Contenu indispensable à produire avant la maquette :")

    # Exercise 7.
    add_exercise_header(doc, "7", "Construire un éditorialisme soutenable", "30 min", "Une matrice de contenus réaliste, avec fréquence, source et responsable.")
    add_callout(doc, "PRINCIPE", "Mieux vaut trois formats utiles et tenus pendant un an que douze rubriques abandonnées après le lancement.", fill=SAGE)
    add_form_table(doc, ["Format", "Public / besoin", "Source", "Fréquence", "Produit par", "Validé par"], [
        ["Actualité catalogue", "", "", "", "", ""],
        ["Sélection saisonnière", "", "", "", "", ""],
        ["Fiche conseil", "", "", "", "", ""],
        ["Dossier métier", "", "", "", "", ""],
        ["Recette / rendement", "", "", "", "", ""],
        ["Portrait client local", "", "", "", "", ""],
        ["Actualité entreprise", "", "", "", "", ""],
        ["Autre :", "", "", "", "", ""],
    ], [1800, 1900, 1400, 1200, 1530, 1530], font_size=7.7)
    doc.add_page_break()
    add_kicker(doc, "Exercice 7  |  suite")
    add_heading(doc, "Règles de publication", 2)
    add_form_table(doc, ["Sujet", "Décision de l’équipe"], [
        ["Date de retrait d’un catalogue expiré", ""],
        ["Nom des fichiers PDF et couvertures", ""],
        ["Validation des prix et informations produit", ""],
        ["Droits sur les photographies", ""],
        ["Ton et vocabulaire métier", ""],
        ["Traitement des contenus obsolètes", ""],
        ["Mesure de la performance", ""],
    ], [3000, 6360], font_size=8.8)
    add_heading(doc, "Capacité réelle", 2)
    add_label_line(doc, "Temps disponible chaque mois pour le site :")
    add_label_line(doc, "Personnes capables de rédiger :")
    add_label_line(doc, "Personnes capables de fournir photos / données :")
    add_label_line(doc, "Frein principal anticipé :")

    # Exercise 8.
    add_exercise_header(doc, "8", "Organiser la gouvernance du site", "25 min", "Un responsable par opération récurrente et une procédure simple pour les urgences.")
    add_form_table(doc, ["Opération", "Réalise", "Valide", "Fréquence / délai", "Outil / source"], [
        ["Mettre à jour un catalogue", "", "", "", ""],
        ["Créer une actualité", "", "", "", ""],
        ["Modifier une famille produit", "", "", "", ""],
        ["Traiter une demande commerciale", "", "", "", ""],
        ["Répondre à un formulaire", "", "", "", ""],
        ["Corriger une erreur urgente", "", "", "", ""],
        ["Vérifier les liens / PDF", "", "", "", ""],
        ["Analyser les statistiques", "", "", "", ""],
        ["Gérer les droits d’accès", "", "", "", ""],
    ], [2500, 1500, 1500, 1900, 1960], font_size=7.9)
    add_heading(doc, "Garde-fous", 2)
    add_checkbox_group(doc, "Avant publication, qui contrôle :", ["Exactitude", "Orthographe", "Droits images", "Date d’expiration", "Affichage mobile", "Liens et formulaire"])
    add_label_line(doc, "Canal d’alerte en cas d’erreur critique :")
    add_label_line(doc, "Délai maximal de correction :")

    # Final synthesis.
    doc.add_page_break()
    add_kicker(doc, "Synthèse de fin d’atelier")
    add_heading(doc, "Les décisions que nous emportons", 1)
    add_form_table(doc, ["Sujet", "Décision validée", "Responsable", "Échéance"], [
        ["Objectif principal", "", "", ""],
        ["Public prioritaire", "", "", ""],
        ["Promesse", "", "", ""],
        ["CTA principal", "", "", ""],
        ["Parcours Devenir client", "", "", ""],
        ["Architecture de l’offre", "", "", ""],
        ["Formats éditoriaux", "", "", ""],
        ["Gouvernance", "", "", ""],
    ], [2100, 4060, 1700, 1500], font_size=8.4)
    add_heading(doc, "Parking", 2)
    add_form_table(doc, ["Question non tranchée", "Information nécessaire", "Responsable", "Date d’arbitrage"], [], [3000, 2960, 1700, 1700], blank_rows=5, font_size=8.4)

    doc.add_page_break()
    add_kicker(doc, "Passage à la conception")
    add_heading(doc, "Contenus et preuves à réunir", 1)
    add_form_table(doc, ["Élément", "Existe ?", "À produire / corriger", "Propriétaire", "Date"], [
        ["Logo et charte", "", "", "", ""],
        ["Photographies réelles", "", "", "", ""],
        ["Chiffres clés vérifiés", "", "", "", ""],
        ["Liste des familles", "", "", "", ""],
        ["Liste des services", "", "", "", ""],
        ["Catalogues et couvertures", "", "", "", ""],
        ["Coordonnées et horaires", "", "", "", ""],
        ["Zone de livraison", "", "", "", ""],
        ["Témoignages autorisés", "", "", "", ""],
        ["Mentions et consentements", "", "", "", ""],
    ], [2200, 1000, 2860, 1900, 1400], font_size=8.1)
    add_heading(doc, "Validation collective", 2)
    add_para(doc, "Nous confirmons que les décisions consignées constituent la base de la maquette UX. Toute modification ultérieure devra préciser la décision remplacée et son impact.", size=10, italic=True)
    add_label_line(doc, "Décideur :")
    add_label_line(doc, "Date de validation :")
    add_label_line(doc, "Prochaine étape / date :")

    # Facilitator appendix.
    doc.add_page_break()
    add_kicker(doc, "Annexe facilitateur")
    add_heading(doc, "Questions de relance", 1)
    prompts = [
        ("Quand tout est prioritaire", "Quel choix ferait le commercial si le visiteur ne voyait qu’un seul écran ?"),
        ("Quand une rubrique est proposée", "Qui peut l’alimenter, avec quelle source et à quelle fréquence ?"),
        ("Quand une preuve est avancée", "Où est la donnée, qui la garantit et quand sera-t-elle revue ?"),
        ("Quand le formulaire s’allonge", "Cette information est-elle indispensable avant le premier rappel ?"),
        ("Quand le groupe parle de l’entreprise", "Quel problème concret du professionnel sommes-nous en train de résoudre ?"),
        ("Quand le template impose un bloc", "Quel objectif utilisateur ce bloc sert-il ?"),
        ("Quand un désaccord persiste", "Quelle donnée ou quel test permettra de l’arbitrer après l’atelier ?"),
    ]
    add_form_table(doc, ["Situation", "Question à poser"], prompts, [2600, 6760], font_size=9)
    add_heading(doc, "Critères de sortie", 2)
    add_checkbox_group(doc, "Avant de clôturer, vérifier que :", [
        "chaque livrable a une décision",
        "chaque chiffre publié a une source",
        "chaque contenu récurrent a un responsable",
        "le délai de réponse commerciale est réaliste",
        "les questions ouvertes ont un propriétaire et une date",
    ])
    add_callout(doc, "APRÈS L’ATELIER", "Le facilitateur consolide ce document sous 48 heures. L’équipe projet le transforme ensuite en arborescence, wireframe annoté, backlog de contenus et spécifications du parcours commercial.", fill=SAGE)

    # Metadata and save.
    props = doc.core_properties
    props.title = "Atelier UX – Gestionnaires du site Cash Alimentaire"
    props.subject = "Support de co-conception du site catalogue professionnel"
    props.author = "Cash Alimentaire"
    props.keywords = "UX, atelier, catalogue, devenir client, éditorial, gouvernance"
    props.comments = "Document de travail généré pour l’atelier UX des futurs gestionnaires."

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    doc.save(OUTPUT)
    print(OUTPUT)


if __name__ == "__main__":
    build()
