//
//  PartViewController.m
//  Rouen2
//
//  Created by Jean-André Santoni on 24/01/14.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "PartViewController.h"
#import "CSLinearLayoutView.h"

@interface PartViewController ()
- (void) addHeader:(int)partNumber title:(NSString*)titleText subtitle:(NSString*)subtitleText;
- (void) addParagraph:(NSString*)text;
- (void) addNextButton:(int)partNumber title:(NSString*)titleText;
@end

CSLinearLayoutView *mainLinearLayout;

@implementation PartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.94 blue:0.89 alpha:1.0];
    
    // create the linear layout view
    mainLinearLayout = [[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    mainLinearLayout.backgroundColor = [UIColor clearColor];
    mainLinearLayout.orientation = CSLinearLayoutViewOrientationVertical;
    [self.view addSubview:mainLinearLayout];

    [self addHeader:1 title:@"Arsène Lupin a vingt ans" subtitle:@"Raoul d’Andrésy jeta sa bicyclette, après en avoir éteint la lanterne, derrière un talus rehaussé de broussailles."];
    
    [self addParagraph:@"Raoul d’Andrésy jeta sa bicyclette, après en avoir éteint la lanterne, derrière un talus rehaussé de broussailles. À ce moment, trois heures sonnaient au clocher de Bénouville."];
    [self addParagraph:@"Dans l’ombre épaisse de la nuit, il suivit le chemin de campagne qui desservait le domaine de la Haie d’Étigues, et parvint ainsi aux murs de l’enceinte. Il attendit un peu. Des chevaux qui piaffent, des roues qui résonnent sur le pavé d’une cour, un bruit de grelots, les deux battants de la porte ouverts d’un coup… et un break passa. À peine Raoul eut-il le temps de percevoir des voix d’hommes et de distinguer le canon d’un fusil. Déjà la voiture gagnait la grand-route et filait vers Étretat."];
    [self addParagraph:@"« Allons, se dit-il, la chasse aux guillemots est captivante, la roche où on les massacre est lointaine… je vais enfin savoir ce que signifient cette partie de chasse improvisée et toutes ces allées et venues. »"];
    [self addParagraph:@"Il longea par la gauche les murs du domaine, les contourna, et, après le deuxième angle, s’arrêta au quarantième pas. Il tenait deux clefs dans sa main. La première ouvrit une petite porte basse, après laquelle il monta un escalier taillé au creux d’un vieux rempart, à moitié démoli, qui flanquait une des ailes du château. La deuxième lui livra une entrée secrète, au niveau du premier étage."];
    [self addParagraph:@"Il alluma sa lampe de poche, et, sans trop de précautions, car il savait que le personnel habitait de l’autre côté, et que Clarisse d’Étigues, la fille unique du baron, demeurait au second, il suivit un couloir qui le conduisit dans un vaste cabinet de travail : c’était là que, quelques semaines auparavant, Raoul avait demandé au baron la main de sa fille, et là qu’il avait été accueilli par une explosion de colère indignée dont il gardait un souvenir désagréable."];
    [self addParagraph:@"Une glace lui renvoya sa pâle figure d’adolescent, plus pâle que d’habitude. Cependant, entraîné aux émotions, il restait maître de lui, et, froidement, il se mit à l’œuvre."];
    [self addParagraph:@"Ce ne fut pas long. Lors de son entretien avec le baron, il avait remarqué que son interlocuteur jetait parfois un coup d’œil sur un grand bureau d’acajou dont le cylindre n’était pas rabattu. Raoul connaissait tous les emplacements où il est possible de pratiquer une cachette, et tous les mécanismes que l’on fait jouer en pareil cas. Une minute après, il découvrait dans une fente une lettre écrite sur du papier très fin et roulé comme une cigarette. Aucune signature, aucune adresse."];
    [self addParagraph:@"Il étudia cette missive dont le texte lui parut d’abord trop banal pour qu’on la dissimulât avec tant de soin, et il put ainsi, grâce à un travail minutieux, en s’accrochant à certains mots plus significatifs, et en supprimant certaines phrases évidemment destinées à remplir les vides, il put ainsi reconstituer ce qui suit :"];
    [self addParagraph:@"« J’ai retrouvé à Rouen les traces de notre ennemie, et j’ai fait insérer dans les journaux de la localité qu’un paysan des environs d’Étretat avait déterré dans sa prairie un vieux chandelier de cuivre à sept branches. Elle a aussitôt télégraphié au voiturier d’Étretat qu’on lui envoie le douze, à trois heures de l’après-midi, un coupé en gare de Fécamp. Le matin de ce jour, le voiturier recevra, par mes soins, une autre dépêche contremandant cet ordre. Ce sera donc votre coupé à vous qu’elle trouvera en gare de Fécamp et qui l’amènera sous bonne escorte, parmi nous, au moment où nous tiendrons notre assemblée."];
    [self addParagraph:@"« Nous pourrons alors nous ériger en tribunal et prononcer contre elle un verdict impitoyable. Aux époques où la grandeur du but justifiait les moyens, le châtiment eût été immédiat. Morte la bête, mort le venin. Choisissez la solution qui vous plaira, mais en vous rappelant les termes de notre dernier entretien, et en vous disant bien que la réussite de nos entreprises, et que notre existence elle-même, dépendent de cette créature infernale. Soyez prudent. Organisez une partie de chasse qui détourne les soupçons. J’arriverai par le Havre, à quatre heures exactement, avec deux de nos amis. Ne détruisez pas cette lettre. Vous me la rendrez. »"];
    [self addParagraph:@"« L’excès de précaution est un défaut, pensa Raoul. Si le correspondant du baron ne s’était pas défié, le baron aurait brûlé ces lignes, et j’ignorerais qu’il y a projet d’enlèvement, projet de jugement illégal, et même, Dieu me pardonne ! projet d’assassinat. Fichtre ! mon futur beau-père, si dévot qu’il soit, me semble empêtré dans des combinaisons peu catholiques. Ira-t-il jusqu’au meurtre ? Tout cela est rudement grave et pourrait bien me donner barre sur lui. »"];
    [self addParagraph:@"Raoul se frotta les mains. L’affaire lui plaisait et ne l’étonnait pas outre mesure, quelques détails ayant éveillé son attention depuis plusieurs jours. Il résolut donc de retourner à son auberge, d’y dormir, puis de s’en revenir à temps pour apprendre ce que complotaient le baron et ses invités, et quelle était cette « créature infernale » dont on souhaitait la suppression."];
    [self addParagraph:@"Il remit tout en ordre, mais, au lieu de partir, il s’assit devant un guéridon où se trouvait une photographie de Clarisse, et, la mettant bien en face de lui, la contempla avec une tendresse profonde. Clarisse d’Étigues, à peine plus jeune que lui !… Dix-huit ans ! Des lèvres voluptueuses… les yeux pleins de rêve… un frais visage de blonde, rose et délicat, avec des cheveux pâles comme en ont les petites filles qui courent sur les routes du pays de Caux, et un air si doux, et tant de charme ! …"];
    [self addParagraph:@"Le regard de Raoul se faisait plus dur. Une pensée mauvaise qu’il ne parvenait pas à dominer, envahissait le jeune homme. Clarisse était seule, là-haut, dans son appartement isolé, et deux fois déjà, se servant des clefs qu’elle-même lui avait confiées, deux fois déjà, à l’heure du thé, il l’y avait rejointe. Alors qui le retenait aujourd’hui ? Aucun bruit ne pouvait parvenir jusqu’aux domestiques. Le baron ne devait rentrer qu’au cours de l’après-midi. Pourquoi s’en aller ?"];
    [self addParagraph:@"Raoul n’était pas un Lovelace. Bien des sentiments de probité et de délicatesse s’opposaient en lui au déchaînement d’instincts et d’appétits dont il connaissait la violence excessive. Mais comment résister à une pareille tentation ? L’orgueil, le désir, l’amour, le besoin impérieux de conquérir, le poussaient à l’action. Sans plus s’attarder à de vains scrupules, il monta vivement les marches de l’escalier."];
    [self addParagraph:@"Devant la porte close, il hésita. S’il l’avait franchie déjà, c’était en plein jour, comme un ami respectueux. Quelle signification, au contraire, prenait un pareil acte à cette heure de la nuit !"];
    [self addParagraph:@"Débat de conscience qui dura peu. À petits coups, il frappa, tout en chuchotant :"];
    [self addParagraph:@"« Clarisse… Clarisse… c’est moi. »"];
    [self addParagraph:@"Au bout d’une minute, n’entendant rien, il allait frapper de nouveau et plus fort, quand la porte du boudoir fut entrebâillée, et la jeune fille apparut, une lampe à la main."];
    [self addParagraph:@"Il remarqua sa pâleur et son épouvante, et cela le bouleversa au point qu’il recula, prêt à partir."];
    [self addParagraph:@"« Ne m’en veux pas, Clarisse… Je suis venu malgré moi… Tu n’as qu’à dire un mot et je m’en vais… »"];
    [self addParagraph:@"Clarisse eût entendu ces paroles qu’elle eût été sauvée. Elle aurait aisément dominé un adversaire qui acceptait d’avance la défaite. Mais elle ne pouvait ni entendre ni voir. Elle voulait s’indigner et ne faisait que balbutier des reproches indistincts. Elle voulait le chasser et son bras n’avait pas la force de faire un seul geste. Sa main qui tremblait dut poser la lampe. Elle tourna sur elle-même et tomba, évanouie…"];
    [self addParagraph:@"Ils s’aimaient depuis trois mois, depuis le jour de leur rencontre dans le Midi où Clarisse passait quelque temps chez une amie de pension."];
    [self addParagraph:@"Tout de suite, ils se sentirent unis par un lien qui fut, pour lui, la chose du monde la plus délicieuse, pour elle, le signe d’un esclavage qu’elle chérissait de plus en plus. Dès le début, Raoul lui sembla un être insaisissable, mystérieux, auquel, jamais, elle ne comprendrait rien. Il la désolait par certains accès de légèreté, d’ironie méchante et d’humeur soucieuse. Mais à côté de cela, quelle séduction ! Quelle gaieté ! Quels soubresauts d’enthousiasme et d’exaltation juvénile. Tous ses défauts prenaient l’apparence de qualités excessives et ses vices avaient un air de vertus qui s’ignorent et qui vont s’épanouir."];
    [self addParagraph:@"Dès son retour en Normandie, elle eut la surprise d’apercevoir, un matin, la fine silhouette du jeune homme, perchée sur un mur, en face de ses fenêtres. Il avait choisi une auberge, à quelques kilomètres de distance, et ainsi, presque chaque jour, s’en vint sur sa bicyclette la retrouver aux environs de la Haie d’Étigues."];
    [self addParagraph:@"Orpheline de mère, Clarisse n’était pas heureuse auprès de son père, homme dur, sombre de caractère, dévot à l’excès, entiché de son titre, âpre au gain, et que ses fermiers redoutaient comme un ennemi. Lorsque Raoul, qui n’avait même pas été présenté, eut l’audace de lui demander la main de sa fille, le baron entra dans une telle fureur contre ce prétendant imberbe, sans situation et sans relations, qu’il l’eût cravaché si le jeune homme ne l’avait regardé d’un petit air de dompteur qui maîtrise une bête féroce."];
    [self addParagraph:@"C’est à la suite de cette entrevue, et pour en effacer le souvenir dans l’esprit de Raoul, que Clarisse commit la faute de lui ouvrir, à deux reprises, la porte de son boudoir. Imprudence dangereuse et dont Raoul s’était prévalu avec toute la logique d’un amoureux."];
    [self addParagraph:@"Ce matin-là, simulant une indisposition, elle se fit apporter le déjeuner de midi tandis que Raoul se cachait dans une pièce voisine, et après le repas, ils restèrent longtemps serrés l’un contre l’autre devant la fenêtre ouverte, unis par le souvenir de leurs baisers et par tout ce qu’il y avait en eux de tendresse et, malgré la faute commise, d’ingénuité."];
    [self addParagraph:@"Cependant Clarisse pleurait…"];
    
    [self addNextButton:2 title:@"Des heures s’écoulèrent"];
}

- (void)addHeader:(int)partNumber title:(NSString *)titleText subtitle:(NSString *)subtitleText
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 500)];
    header.backgroundColor = [UIColor colorWithRed:0.75 green:0.70 blue:0.69 alpha:1.0];
    
    UITextView *title = [[UITextView alloc] initWithFrame:CGRectMake(85, 85*1.5, 768-85, 0)];
    title.text = [NSString stringWithFormat:@"%d. %@", partNumber, titleText];
    title.font = [UIFont fontWithName:@"SuperClarendon-Black" size:50];
    title.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
    title.backgroundColor = [UIColor clearColor];
    title.userInteractionEnabled = NO;
    title.scrollEnabled = NO;
    [title sizeToFit];
    [header addSubview:title];
    
    UITextView *subtitle = [[UITextView alloc] initWithFrame:CGRectMake(85, 85*3.5, 768-85, 0)];
    subtitle.text = subtitleText;
    subtitle.font = [UIFont fontWithName:@"SuperClarendon-Black" size:30];
    subtitle.textColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.22 alpha:1.0];
    subtitle.backgroundColor = [UIColor clearColor];
    subtitle.userInteractionEnabled = NO;
    subtitle.scrollEnabled = NO;
    [subtitle sizeToFit];
    [header addSubview:subtitle];

    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:header];
    item.padding = CSLinearLayoutMakePadding(0, 0, 85, 0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentLeft;
    item.fillMode = CSLinearLayoutItemFillModeNormal;

    [mainLinearLayout addItem:item];
}

- (void)addParagraph:(NSString *)text
{
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 512, 0)];
    tv.text = text;
    tv.font = [UIFont fontWithName:@"Georgia" size:18];
    tv.textAlignment = NSTextAlignmentJustified;
    tv.userInteractionEnabled = NO;
    tv.scrollEnabled = NO;
    [tv sizeToFit];
    tv.backgroundColor = [UIColor clearColor];
    tv.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];

    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:tv];
    item.padding = CSLinearLayoutMakePadding(0, 85, 0, 0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentLeft;
    item.fillMode = CSLinearLayoutItemFillModeNormal;
    
    [mainLinearLayout addItem:item];
}

- (void)addNextButton:(int)partNumber title:(NSString *)titleText
{
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 768, 300)];
    nextButton.backgroundColor = [UIColor colorWithRed:0.75 green:0.70 blue:0.69 alpha:1.0];

    UITextView *nextPartLabel = [[UITextView alloc] initWithFrame:CGRectMake(85, 100, 768-85, 0)];
    nextPartLabel.text = [NSString stringWithFormat:@"Episode %d.", partNumber];
    nextPartLabel.font = [UIFont fontWithName:@"SuperClarendon-Black" size:30];
    nextPartLabel.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
    nextPartLabel.backgroundColor = [UIColor clearColor];
    nextPartLabel.userInteractionEnabled = NO;
    nextPartLabel.scrollEnabled = NO;
    [nextPartLabel sizeToFit];
    [nextButton addSubview:nextPartLabel];
    
    UITextView *title = [[UITextView alloc] initWithFrame:CGRectMake(85, 150, 768-85, 0)];
    title.text = titleText;
    title.font = [UIFont fontWithName:@"SuperClarendon-Black" size:30];
    title.textColor = [UIColor colorWithRed:0.08 green:0.07 blue:0.07 alpha:1.0];
    title.backgroundColor = [UIColor clearColor];
    title.userInteractionEnabled = NO;
    title.scrollEnabled = NO;
    [title sizeToFit];
    [nextButton addSubview:title];
    
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:nextButton];
    item.padding = CSLinearLayoutMakePadding(85, 0, 0, 0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentLeft;
    item.fillMode = CSLinearLayoutItemFillModeNormal;
    
    [mainLinearLayout addItem:item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
