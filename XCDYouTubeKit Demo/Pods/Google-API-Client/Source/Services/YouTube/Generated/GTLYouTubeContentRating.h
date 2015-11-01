/* Copyright (c) 2014 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  GTLYouTubeContentRating.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   YouTube Data API (youtube/v3)
// Description:
//   Programmatic access to YouTube features.
// Documentation:
//   https://developers.google.com/youtube/v3
// Classes:
//   GTLYouTubeContentRating (0 custom class methods, 64 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeContentRating
//

// Ratings schemes. The country-specific ratings are mostly for movies and
// shows. NEXT_ID: 65

@interface GTLYouTubeContentRating : GTLObject

// Rating system in Australia - Australian Classification Board
@property (copy) NSString *acbRating;

// Rating system for Italy - Autorit� per le Garanzie nelle Comunicazioni
@property (copy) NSString *agcomRating;

// Rating system for Chile - Asociaci�n Nacional de Televisi�n
@property (copy) NSString *anatelRating;

// British Board of Film Classification
@property (copy) NSString *bbfcRating;

// Rating system for Thailand - Board of Filmand Video Censors
@property (copy) NSString *bfvcRating;

// Rating system for Austria - Bundesministeriums f�r Unterricht, Kunst und
// Kultur!
@property (copy) NSString *bmukkRating;

// Rating system for French Canadian TV - Regie du cinema
@property (copy) NSString *catvfrRating;

// Rating system for Canadian TV - Canadian TV Classification System
@property (copy) NSString *catvRating;

// Rating system in India - Central Board of Film Certification
@property (copy) NSString *cbfcRating;

// Rating system for Chile - Consejo de Calificaci�n Cinematogr�fica
@property (copy) NSString *cccRating;

// Rating system for Portugal - Comiss�o de Classifica��o de Espect�culos
@property (copy) NSString *cceRating;

// Rating system for Switzerland - Switzerland Rating System
@property (copy) NSString *chfilmRating;

// Canadian Home Video Rating System
@property (copy) NSString *chvrsRating;

// Rating system for Belgium - Belgium Rating System
@property (copy) NSString *cicfRating;

// Rating system for Romania - CONSILIUL NATIONAL AL AUDIOVIZUALULUI - CNA
@property (copy) NSString *cnaRating;

// Rating system for France - Conseil sup�rieur de l?audiovisuel
@property (copy) NSString *csaRating;

// Rating system for Luxembourg - Commission de surveillance de la
// classification des films
@property (copy) NSString *cscfRating;

// Rating system for Czech republic - Czech republic Rating System
@property (copy) NSString *czfilmRating;

// Rating system in Brazil - Department of Justice, Rating, Titles and
// Qualification
@property (copy) NSString *djctqRating;

@property (retain) NSArray *djctqRatingReasons;  // of NSString

// Rating system for Estonia - Estonia Rating System
@property (copy) NSString *eefilmRating;

// Rating system for Egypt - Egypt Rating System
@property (copy) NSString *egfilmRating;

// Rating system in Japan - Eiga Rinri Kanri Iinkai
@property (copy) NSString *eirinRating;

// Rating system for Malaysia - Film Censorship Board of Malaysia
@property (copy) NSString *fcbmRating;

// Rating system for Hong kong - Office for Film, Newspaper and Article
// Administration
@property (copy) NSString *fcoRating;

// Rating system in France - French Minister of Culture
@property (copy) NSString *fmocRating;

// Rating system for South africa - Film & Publication Board
@property (copy) NSString *fpbRating;

// Rating system in Germany - Voluntary Self Regulation of the Movie Industry
@property (copy) NSString *fskRating;

// Rating system for Greece - Greece Rating System
@property (copy) NSString *grfilmRating;

// Rating system in Spain - Instituto de Cinematografia y de las Artes
// Audiovisuales
@property (copy) NSString *icaaRating;

// Rating system in Ireland - Irish Film Classification Office
@property (copy) NSString *ifcoRating;

// Rating system for Israel - Israel Rating System
@property (copy) NSString *ilfilmRating;

// Rating system for Argentina - Instituto Nacional de Cine y Artes
// Audiovisuales
@property (copy) NSString *incaaRating;

// Rating system for Kenya - Kenya Film Classification Board
@property (copy) NSString *kfcbRating;

// Rating system for Netherlands - Nederlands Instituut voor de Classificatie
// van Audiovisuele Media
@property (copy) NSString *kijkwijzerRating;

// Rating system in South Korea - Korea Media Rating Board
@property (copy) NSString *kmrbRating;

// Rating system for Indonesia - Lembaga Sensor Film
@property (copy) NSString *lsfRating;

// Rating system for Malta - Film Age-Classification Board
@property (copy) NSString *mccaaRating;

// Rating system for Denmark - The Media Council for Children and Young People
@property (copy) NSString *mccypRating;

// Rating system for Singapore - Media Development Authority
@property (copy) NSString *mdaRating;

// Rating system for Norway - Medietilsynet
@property (copy) NSString *medietilsynetRating;

// Rating system for Finland - Finnish Centre for Media Education and
// Audiovisual Media
@property (copy) NSString *mekuRating;

// Rating system in Italy - Ministero dei Beni e delle Attivita Culturali e del
// Turismo
@property (copy) NSString *mibacRating;

// Rating system for Colombia - MoC
@property (copy) NSString *mocRating;

// Rating system for Taiwan - Ministry of Culture - Tawan
@property (copy) NSString *moctwRating;

// Motion Picture Association of America rating for the content.
@property (copy) NSString *mpaaRating;

// Rating system for Philippines - MOVIE AND TELEVISION REVIEW AND
// CLASSIFICATION BOARD
@property (copy) NSString *mtrcbRating;

// Rating system for Poland - National Broadcasting Council
@property (copy) NSString *nbcplRating;

// Rating system for Maldives - National Bureau of Classification
@property (copy) NSString *nbcRating;

// Rating system for Bulgaria - National Film Centre
@property (copy) NSString *nfrcRating;

// Rating system for Nigeria - National Film and Video Censors Board
@property (copy) NSString *nfvcbRating;

// Rating system for Latvia - National Film Center of Latvia
@property (copy) NSString *nkclvRating;

// Rating system in New Zealand - Office of Film and Literature Classification
@property (copy) NSString *oflcRating;

// Rating system for Peru - Peru Rating System
@property (copy) NSString *pefilmRating;

// Rating system for Hungary - Rating Committee of the National Office of Film
@property (copy) NSString *rcnofRating;

// Rating system for Venezuela - SiBCI
@property (copy) NSString *resorteviolenciaRating;

// Rating system in Mexico - General Directorate of Radio, Television and
// Cinematography
@property (copy) NSString *rtcRating;

// Rating system for Ireland - Raidi� Teilif�s �ireann
@property (copy) NSString *rteRating;

// Rating system in Russia
@property (copy) NSString *russiaRating;

// Rating system for Slovakia - Slovakia Rating System
@property (copy) NSString *skfilmRating;

// Rating system for Iceland - SMAIS
@property (copy) NSString *smaisRating;

// Rating system for Sweden - Statens medier�d (National Media Council)
@property (copy) NSString *smsaRating;

// TV Parental Guidelines rating of the content.
@property (copy) NSString *tvpgRating;

// Internal YouTube rating.
@property (copy) NSString *ytRating;

@end
