import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';

dynamic doCalcs(
  int? prazo,
  double? taxa,
  double? valorInicial,
  double? valorRecorrente,
  double? rendaPassiva,
) {
  String formatarBR(double valor) {
    final negativo = valor < 0;
    final valorAbsoluto = valor.abs();
    final partes = valorAbsoluto.toStringAsFixed(2).split('.');
    final inteiro = partes[0];
    final decimal = partes[1];

    final regex = RegExp(r'\B(?=(\d{3})+(?!\d))');
    final inteiroFormatado = inteiro.replaceAllMapped(regex, (match) => '.');

    return '${negativo ? '-' : ''}$inteiroFormatado,$decimal';
  }

  prazo = (prazo == 0 || prazo == null) ? null : prazo;
  taxa = (taxa == 0 || taxa == null) ? null : taxa;
  valorInicial =
      (valorInicial == 0 || valorInicial == null) ? null : valorInicial;
  valorRecorrente = (valorRecorrente == 0 || valorRecorrente == null)
      ? null
      : valorRecorrente;
  rendaPassiva =
      (rendaPassiva == 0 || rendaPassiva == null) ? null : rendaPassiva;

  double valorInicialCalculado = 0.0;
  double valorRecorrenteCalculado = 0.0;
  double rendaCalculada = 0.0;
  double taxaCalculada = 0.0;
  double valorAcumulado = 0.0;
  double valorTotalAplicado = 0.0;
  double rendimentos = 0.0;
  int prazoCalculado = prazo ?? 0;
  bool resultPrazo = false;
  String message = "";

  // Calcular o prazo
  if (prazo == null &&
      valorInicial != null &&
      valorRecorrente != null &&
      taxa != null &&
      rendaPassiva != null) {
    double vlrAtual = valorInicial;
    double montante = rendaPassiva / (taxa / 100);
    int loop = 0;
    bool continuar = true;

    while (continuar) {
      if (vlrAtual * (1 + taxa / 100) + valorRecorrente < montante) {
        vlrAtual = vlrAtual * (1 + taxa / 100) + valorRecorrente;
      } else {
        continuar = false;
      }
      loop++;
    }

    prazoCalculado = loop - 1;
    valorInicialCalculado = valorInicial;
    valorRecorrenteCalculado = valorRecorrente;
    valorTotalAplicado = valorInicial + (valorRecorrente * (loop - 1));
    valorAcumulado = vlrAtual;
    rendimentos = vlrAtual - valorRecorrente * (loop - 1) - valorInicial;
    rendaCalculada = vlrAtual * (taxa / 100);
    taxaCalculada = taxa;
    resultPrazo = true;
  }

  // Calcular o valor inicial
  else if (prazo != null &&
      valorInicial == null &&
      valorRecorrente != null &&
      taxa != null &&
      rendaPassiva != null) {
    double montante = rendaPassiva / (taxa / 100);
    double taxaAtualizada = math.pow(1 + taxa / 100, prazo).toDouble();
    double valorRecorrenteAtualizado =
        valorRecorrente * ((taxaAtualizada - 1) / (taxa / 100));
    valorInicialCalculado =
        (montante - valorRecorrenteAtualizado) / taxaAtualizada;

    valorRecorrenteCalculado = valorRecorrente;
    valorTotalAplicado = valorInicialCalculado + (valorRecorrente * prazo);
    valorAcumulado = montante;
    rendimentos =
        valorAcumulado - valorRecorrente * prazo - valorInicialCalculado;
    rendaCalculada = montante * (taxa / 100);
    taxaCalculada = taxa;

    String valorInicialFormatado = formatarBR(valorInicialCalculado);
    message = "O valor inicial necessário é R\$ $valorInicialFormatado";
  }

  // Calcular o valor recorrente
  else if (prazo != null &&
      valorInicial != null &&
      valorRecorrente == null &&
      taxa != null &&
      rendaPassiva != null) {
    double montante = rendaPassiva / (taxa / 100);
    double valorInicialAtualizado =
        valorInicial * math.pow(1 + taxa / 100, prazo).toDouble();
    double taxaAtualizada =
        ((math.pow(1 + taxa / 100, prazo) - 1) / (taxa / 100)).toDouble();

    valorRecorrenteCalculado =
        (montante - valorInicialAtualizado) / taxaAtualizada;

    valorInicialCalculado = valorInicial;
    valorTotalAplicado = valorInicial + valorRecorrenteCalculado * prazo;
    valorAcumulado = montante;
    rendimentos =
        valorAcumulado - valorRecorrenteCalculado * prazo - valorInicial;
    rendaCalculada = montante * (taxa / 100);
    taxaCalculada = taxa;

    String valorRecorrenteFormatado = formatarBR(valorRecorrenteCalculado);
    message =
        "O valor recorrente mensal necessário é R\$ $valorRecorrenteFormatado";
  }

  // Calcular a taxa
  else if (prazo != null &&
      valorInicial != null &&
      valorRecorrente != null &&
      taxa == null &&
      rendaPassiva != null) {
    double t = 0.01;
    bool continuar = true;
    double montante = 0.0;

    while (continuar) {
      montante = valorInicial * math.pow(1 + t / 100, prazo) +
          valorRecorrente *
              ((math.pow(1 + t / 100, prazo) - 1) / (t / 100)).toDouble();
      if (montante * (t / 100) >= rendaPassiva) {
        continuar = false;
      } else {
        t += 0.01;
      }
    }

    valorInicialCalculado = valorInicial;
    valorRecorrenteCalculado = valorRecorrente;
    valorTotalAplicado = valorInicial + valorRecorrente * prazo;
    valorAcumulado = montante;
    rendimentos = valorAcumulado - valorRecorrente * prazo - valorInicial;
    rendaCalculada = montante * (t / 100);
    taxaCalculada = t;

    String taxaFormatada =
        taxaCalculada.toStringAsFixed(2).replaceAll('.', ',');
    message = "A taxa necessária é de $taxaFormatada%";
  }

  // Calcular a renda passiva
  else if (prazo != null &&
      valorInicial != null &&
      valorRecorrente != null &&
      taxa != null &&
      rendaPassiva == null) {
    valorAcumulado = valorRecorrente *
            ((math.pow(1 + taxa / 100, prazo) - 1) / (taxa / 100)) +
        valorInicial * math.pow(1 + taxa / 100, prazo).toDouble();

    valorInicialCalculado = valorInicial;
    valorRecorrenteCalculado = valorRecorrente;
    valorTotalAplicado = valorInicial + valorRecorrente * prazo;
    rendimentos = valorAcumulado - valorRecorrente * prazo - valorInicial;
    rendaCalculada = valorAcumulado * (taxa / 100);
    taxaCalculada = taxa;

    String rendaFormatada = formatarBR(rendaCalculada);
    message = "A renda passiva é de R\$ $rendaFormatada";
  }

  // Todos estão preenchidos
  else if (prazo != null &&
      valorInicial != null &&
      valorRecorrente != null &&
      taxa != null &&
      rendaPassiva != null) {
    valorInicialCalculado = valorInicial;
    valorRecorrenteCalculado = valorRecorrente;
    valorTotalAplicado = valorInicial + valorRecorrente * prazo;
    valorAcumulado = rendaPassiva / (taxa / 100);
    rendimentos = valorAcumulado - valorRecorrente * prazo - valorInicial;
    rendaCalculada = rendaPassiva;
    taxaCalculada = taxa;
  }

  // Mais de um campo não está preenchido
  else {
    valorInicialCalculado = 0.0;
    valorRecorrenteCalculado = 0.0;
    valorTotalAplicado = 0.0;
    valorAcumulado = 0.0;
    rendimentos = 0.0;
    rendaCalculada = 0.0;
    taxaCalculada = 0.0;
  }

  // Calcular text (mês ou meses) para o prazo
  final p = prazoCalculado;

  String prazoText = p == 1 ? 'mês' : 'meses';

  String prazoFormatado = (p ~/ 12) > 0
      ? '${(p ~/ 12)} ano${(p ~/ 12) == 1 ? '' : 's'}'
          '${(p % 12) > 0 ? ' e ${(p % 12)} ${(p % 12) == 1 ? 'mês' : 'meses'}' : ''}'
      : '${(p % 12)} ${(p % 12) == 1 ? 'mês' : 'meses'}';

  prazoFormatado += ' (ou $p $prazoText)';

  if (resultPrazo) {
    message = "O prazo pra alcançar a renda passiva é de $prazoFormatado";
  }

  // Retornar os resultados
  return {
    'prazo': prazoCalculado,
    'valorInicialAplicado':
        double.parse(valorInicialCalculado.toStringAsFixed(2)),
    'valorInicialAplicadoFormatado': 'R\$ ${formatarBR(valorInicialCalculado)}',
    'valorRecorrenteMensal':
        double.parse(valorRecorrenteCalculado.toStringAsFixed(2)),
    'valorRecorrenteMensalFormatado':
        'R\$ ${formatarBR(valorRecorrenteCalculado)}',
    'valorRecorrenteTotal': double.parse(
        (valorRecorrenteCalculado * prazoCalculado).toStringAsFixed(2)),
    'valorRecorrenteTotalFormatado':
        'R\$ ${formatarBR(valorRecorrenteCalculado * prazoCalculado)}',
    'valorTotalAplicado': double.parse(valorTotalAplicado.toStringAsFixed(2)),
    'valorTotalAplicadoFormatado': 'R\$ ${formatarBR(valorTotalAplicado)}',
    'valorAcumulado': double.parse(valorAcumulado.toStringAsFixed(2)),
    'valorAcumuladoFormatado': 'R\$ ${formatarBR(valorAcumulado)}',
    'rendimentos': double.parse(rendimentos.toStringAsFixed(2)),
    'rendimentosFormatado': 'R\$ ${formatarBR(rendimentos)}',
    'valorRenda': double.parse(rendaCalculada.toStringAsFixed(2)),
    'valorRendaFormatado': 'R\$ ${formatarBR(rendaCalculada)}',
    'taxa': double.parse(taxaCalculada.toStringAsFixed(2)),
    'taxaFormatada':
        '${taxaCalculada.toStringAsFixed(2).replaceAll('.', ',')}%',
    'prazoFormatado': prazoFormatado,
    'message': message,
    'date': DateTime.now().toString(),
  };
}

dynamic checkFields(
  String? var1,
  String? var2,
  String? var3,
  String? var4,
  String? var5,
) {
  /// Cria uma lista com todas as variáveis
  List vars = [var1, var2, var3, var4, var5];

  // Função auxiliar para verificar se a string representa zero
  bool isZero(String? value) {
    if (value == null || value.isEmpty) return true;

    // Remove pontos (separador de milhares) e converte vírgula em ponto (decimal)
    String normalizedValue = value.replaceAll('.', '').replaceAll(',', '.');

    // Tenta converter para número e verificar se é zero
    return double.tryParse(normalizedValue) == 0;
  }

  // Conta quantas variáveis estão vazias, nulas ou são zero
  int countInvalid = vars
      .where((v) => v == null || (v is String && (v.isEmpty || isZero(v))))
      .length;

  // Verifica as condições
  if (countInvalid != 1) {
    return false;
  }

  return true;
}

String formatResults(
  String valorInvestido,
  String valorRecorrente,
  String rendimentos,
  String valorAcumulado,
  String taxaMensal,
  String valorRendaPassiva,
  String valorInicial,
  String prazo,
  bool isAndroid,
) {
  String storeUrl = isAndroid
      ? 'https://play.google.com/store/apps/details?id=com.cwrsiqueira.crp_app'
      : 'https://apps.apple.com/app/calculadora-renda-passiva/id6762054224';

  // Retornando a string formatada
  return '''
CALCULADORA DE RENDA PASSIVA
Baixe grátis:
$storeUrl

Resultados:
Prazo: $prazo
Valor Investido: $valorInvestido
Valor Inicial: $valorInicial
Valor Recorrente: $valorRecorrente
Rendimentos: $rendimentos
Valor Acumulado: $valorAcumulado
Taxa Mensal: $taxaMensal
Valor da Renda Passiva: $valorRendaPassiva
''';
}

dynamic versiculoRendaPassivaAleatorio(String? tipo) {
  final random = math.Random();

  final versiculos = <Map<String, String>>[
    {
      "versiculo":
          "Tesouro desejável e azeite há na casa do sábio, mas o homem insensato os devora.",
      "fonte": "Provérbios 21:20",
    },
    {
      "versiculo":
          "Lança o teu pão sobre as águas, porque depois de muitos dias o acharás.",
      "fonte": "Eclesiastes 11:1",
    },
    {
      "versiculo":
          "Devias então ter dado o meu dinheiro aos banqueiros, e, quando eu viesse, receberia o meu com os juros.",
      "fonte": "Mateus 25:27",
    },
    {
      "versiculo": "Negociai até que eu venha.",
      "fonte": "Lucas 19:13",
    },
    {
      "versiculo":
          "Bem está, servo bom e fiel. Sobre o pouco foste fiel, sobre muito te colocarei.",
      "fonte": "Mateus 25:21",
    },
    {
      "versiculo":
          "A riqueza obtida às pressas diminuirá, mas quem a ajunta pouco a pouco terá aumento.",
      "fonte": "Provérbios 13:11",
    },
    {
      "versiculo": "Tudo o que o homem semear, isso também ceifará.",
      "fonte": "Gálatas 6:7",
    },
    {
      "versiculo":
          "O que semeia pouco, pouco também ceifará; e o que semeia em abundância, em abundância ceifará.",
      "fonte": "2 Coríntios 9:6",
    },
    {
      "versiculo":
          "Será como a árvore plantada junto a ribeiros de águas, que dá o seu fruto na estação própria.",
      "fonte": "Salmos 1:3",
    },
    {
      "versiculo": "A mão remissa empobrece, mas a mão diligente enriquece.",
      "fonte": "Provérbios 10:4",
    },
    {
      "versiculo": "Os pensamentos do diligente conduzem à fartura.",
      "fonte": "Provérbios 21:5",
    },
    {
      "versiculo":
          "Qual de vós, querendo edificar uma torre, não se assenta primeiro a fazer as contas dos gastos?",
      "fonte": "Lucas 14:28",
    },
    {
      "versiculo":
          "Prepara de fora a tua obra, apronta-a no campo, e depois edifica a tua casa.",
      "fonte": "Provérbios 24:27",
    },
    {
      "versiculo":
          "Vai ter com a formiga, ó preguiçoso; olha para os seus caminhos, e sê sábio. Pois ela, não tendo chefe, nem oficial, nem comandante, no verão prepara o seu pão; na sega ajunta o seu mantimento.",
      "fonte": "Provérbios 6:6-8",
    },
    {
      "versiculo":
          "Confia ao Senhor as tuas obras, e teus pensamentos serão estabelecidos.",
      "fonte": "Provérbios 16:3",
    },
    {
      "versiculo": "Quem é fiel no mínimo também é fiel no muito.",
      "fonte": "Lucas 16:10",
    },
    {
      "versiculo":
          "Se nas riquezas injustas não fostes fiéis, quem vos confiará as verdadeiras?",
      "fonte": "Lucas 16:11",
    },
    {
      "versiculo":
          "Porque a qualquer que tiver será dado, e terá em abundância; mas ao que não tiver até o que tem ser-lhe-á tirado.",
      "fonte": "Mateus 25:29",
    },
    {
      "versiculo": "Procura conhecer o estado das tuas ovelhas.",
      "fonte": "Provérbios 27:23",
    },
    {
      "versiculo":
          "Examina uma propriedade e adquire-a; planta uma vinha com o fruto de suas mãos.",
      "fonte": "Provérbios 31:16",
    },
    {
      "versiculo": "O que lavra a sua terra se fartará de pão.",
      "fonte": "Provérbios 12:11",
    },
    {
      "versiculo": "Em todo trabalho há proveito.",
      "fonte": "Provérbios 14:23",
    },
    {
      "versiculo": "O que lavra a sua terra terá abundância de pão.",
      "fonte": "Provérbios 28:19",
    },
    {
      "versiculo": "Pois comerás do trabalho das tuas mãos.",
      "fonte": "Salmos 128:2",
    },
    {
      "versiculo": "Tudo quanto fizerdes, fazei-o de todo o coração.",
      "fonte": "Colossenses 3:23",
    },
    {
      "versiculo":
          "Antes te lembrarás do Senhor teu Deus, que te dá força para adquirires riquezas.",
      "fonte": "Deuteronômio 8:18",
    },
    {
      "versiculo":
          "O Senhor abrirá o seu bom tesouro... para abençoar toda obra das tuas mãos.",
      "fonte": "Deuteronômio 28:12",
    },
    {
      "versiculo":
          "Que todo homem coma e beba e goze do bem de todo o seu trabalho.",
      "fonte": "Eclesiastes 3:13",
    },
    {
      "versiculo": "Quanto ao homem a quem Deus deu riquezas e bens.",
      "fonte": "Eclesiastes 5:19",
    },
    {
      "versiculo": "Então farás prosperar o teu caminho e serás bem-sucedido.",
      "fonte": "Josué 1:8",
    },
  ];

  final motivacionais = <Map<String, String>>[
    {
      "versiculo": "Comece onde você está, use o que tem e faça o que pode.",
      "fonte": "Squire Bill Widener",
    },
    {
      "versiculo": "A jornada de mil milhas começa debaixo dos seus pés.",
      "fonte": "Laozi",
    },
    {
      "versiculo": "Uma árvore imensa nasce de um broto minúsculo.",
      "fonte": "Laozi",
    },
    {
      "versiculo": "Aprender com perseverança é uma alegria.",
      "fonte": "Confúcio",
    },
    {
      "versiculo": "Quando vir alguém de valor, pense em igualá-lo.",
      "fonte": "Confúcio",
    },
    {
      "versiculo": "A pessoa superior é modesta no falar e abundante no agir.",
      "fonte": "Confúcio",
    },
    {
      "versiculo": "Aja antes de falar; depois, fale de acordo com suas ações.",
      "fonte": "Confúcio",
    },
    {
      "versiculo":
          "O que antes era obstáculo pode se tornar o próprio caminho.",
      "fonte": "Marco Aurélio",
    },
    {
      "versiculo": "Aquilo que está fora de você não comanda a sua opinião.",
      "fonte": "Marco Aurélio",
    },
    {
      "versiculo":
          "Faça o que é justo e fale a verdade; nisso há uma vida feliz.",
      "fonte": "Marco Aurélio",
    },
    {
      "versiculo": "Não temos pouco tempo; desperdiçamos muito.",
      "fonte": "Sêneca",
    },
    {
      "versiculo":
          "O problema não é a vida ser curta, mas o mau uso que fazemos dela.",
      "fonte": "Sêneca",
    },
    {
      "versiculo":
          "As pessoas se perturbam não pelas coisas, mas pelas opiniões que fazem delas.",
      "fonte": "Epicteto",
    },
    {
      "versiculo":
          "Não falhei; apenas encontrei milhares de maneiras que não funcionam.",
      "fonte": "Thomas Edison",
    },
    {
      "versiculo":
          "Gênio é um por cento inspiração e noventa e nove por cento transpiração.",
      "fonte": "Thomas Edison",
    },
    {
      "versiculo": "Nossa maior fraqueza está em desistir; tente mais uma vez.",
      "fonte": "Thomas Edison",
    },
    {
      "versiculo": "Não há substituto para o trabalho duro.",
      "fonte": "Thomas Edison",
    },
    {
      "versiculo": "O otimismo é a fé que leva à realização.",
      "fonte": "Helen Keller",
    },
    {
      "versiculo": "Sozinhos fazemos pouco; juntos fazemos muito mais.",
      "fonte": "Helen Keller",
    },
    {
      "versiculo": "Faça de cada dia a sua obra-prima.",
      "fonte": "John Wooden",
    },
    {
      "versiculo": "A disciplina é a ponte entre pensamento e realização.",
      "fonte": "Jim Rohn",
    },
    {
      "versiculo":
          "O que você se torna ao alcançar seus objetivos é mais importante do que o que conquista.",
      "fonte": "Zig Ziglar",
    },
    {
      "versiculo":
          "Espere o melhor, prepare-se para o pior e aproveite o que vier.",
      "fonte": "Zig Ziglar",
    },
    {
      "versiculo":
          "O sucesso acontece quando a oportunidade encontra a preparação.",
      "fonte": "Zig Ziglar",
    },
    {
      "versiculo":
          "Todo feito, toda riqueza conquistada, começa por uma ideia.",
      "fonte": "Napoleon Hill",
    },
    {
      "versiculo":
          "Valorize suas visões e seus sonhos; eles são os mapas das suas conquistas.",
      "fonte": "Napoleon Hill",
    },
    {
      "versiculo":
          "A coragem é resistência ao medo, domínio do medo, não ausência dele.",
      "fonte": "Mark Twain",
    },
    {
      "versiculo":
          "O sucesso se mede mais pelos obstáculos superados do que pela posição alcançada.",
      "fonte": "Booker T. Washington",
    },
    {
      "versiculo": "Avance com confiança na direção dos seus sonhos.",
      "fonte": "Henry David Thoreau",
    },
    {
      "versiculo":
          "Tente não ser uma pessoa de sucesso, mas uma pessoa de valor.",
      "fonte": "Albert Einstein",
    },
  ];

  final engracadas = <Map<String, String>>[
    {
      "versiculo": "A vida é curta. Sorria enquanto ainda tem dentes.",
      "fonte": "Autor desconhecido, provavelmente um dentista",
    },
    {
      "versiculo":
          "Se o plano não der certo, relaxa. O alfabeto tem mais 25 letras.",
      "fonte": "Autor desconhecido",
    },
    {
      "versiculo":
          "Acordar cedo é o primeiro passo para passar o dia inteiro com sono.",
      "fonte": "Autor desconhecido, porém experiente",
    },
    {
      "versiculo":
          "Não deixe para amanhã o que você pode deixar para depois de amanhã.",
      "fonte": "Mark Twain",
    },
    {
      "versiculo":
          "O importante não é vencer todos os dias, mas dormir sem boleto vencido.",
      "fonte": "Autor desconhecido, brasileiro certamente",
    },
    {
      "versiculo":
          "Trabalhe duro em silêncio e deixe seu boleto fazer barulho.",
      "fonte": "Coach desconhecido",
    },
    {
      "versiculo": "Se dinheiro não traz felicidade, me dê o seu e seja feliz.",
      "fonte": "Autor desconhecido e muito prestativo",
    },
    {
      "versiculo": "Eu não sou preguiçoso, estou em modo economia de energia.",
      "fonte": "Autor desconhecido, versão 2.0",
    },
    {
      "versiculo": "Nunca desista dos seus sonhos. Continue dormindo.",
      "fonte": "Autor desconhecido",
    },
    {
      "versiculo": "Errar é humano. Colocar a culpa no sistema é tecnologia.",
      "fonte": "Autor desconhecido do TI",
    },
    {
      "versiculo": "A fé move montanhas, mas o café move pessoas.",
      "fonte": "Autor desconhecido, cafeinado",
    },
    {
      "versiculo": "Hoje eu acordei disposto. Disposto a voltar para a cama.",
      "fonte": "Autor desconhecido",
    },
    {
      "versiculo": "Tudo passa. Nem que seja no cartão de crédito.",
      "fonte": "Autor desconhecido",
    },
    {
      "versiculo":
          "O sucesso é uma escada. O problema é que às vezes eu procuro o elevador.",
      "fonte": "Autor desconhecido",
    },
    {
      "versiculo":
          "A vida é feita de escolhas. Hoje escolhi mais cinco minutos.",
      "fonte": "Autor desconhecido",
    },
  ];

  List<Map<String, String>> mostrar;

  if (tipo == 'versiculos') {
    mostrar = versiculos;
  } else if (tipo == 'motivacionais') {
    mostrar = motivacionais;
  } else if (tipo == 'engracadas') {
    mostrar = engracadas;
  } else {
    mostrar = versiculos;
  }

  return mostrar[random.nextInt(mostrar.length)];
}
