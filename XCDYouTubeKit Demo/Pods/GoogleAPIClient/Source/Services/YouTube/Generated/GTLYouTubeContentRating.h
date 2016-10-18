/* Copyright (c) 2016 Google Inc.
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
//   Supports core YouTube features, such as uploading videos, creating and
//   managing playlists, searching for content, and much more.
// Documentation:
//   https://developers.google.com/youtube/v3
// Classes:
//   GTLYouTubeContentRating (0 custom class methods, 66 custom properties)

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
// shows. NEXT_ID: 67

@interface GTLYouTubeContentRating : GTLObject

// The video's Australian Classification Board (ACB) or Australian
// Communications and Media Authority (ACMA) rating. ACMA ratings are used to
// classify children's television programming.
@property (nonatomic, copy) NSString *acbRating;

// The video's rating from Italy's Autorità per le Garanzie nelle Comunicazioni
// (AGCOM).
@property (nonatomic, copy) NSString *agcomRating;

// The video's Anatel (Asociación Nacional de Televisión) rating for Chilean
// television.
@property (nonatomic, copy) NSString *anatelRating;

// The video's British Board of Film Classification (BBFC) rating.
@property (nonatomic, copy) NSString *bbfcRating;

// The video's rating from Thailand's Board of Film and Video Censors.
@property (nonatomic, copy) NSString *bfvcRating;

// The video's rating from the Austrian Board of Media Classification
// (Bundesministerium für Unterricht, Kunst und Kultur).
@property (nonatomic, copy) NSString *bmukkRating;

// The video's rating from the Canadian Radio-Television and Telecommunications
// Commission (CRTC) for Canadian French-language broadcasts. For more
// information, see the Canadian Broadcast Standards Council website.
@property (nonatomic, copy) NSString *catvfrRating;

// Rating system for Canadian TV - Canadian TV Classification System The video's
// rating from the Canadian Radio-Television and Telecommunications Commission
// (CRTC) for Canadian English-language broadcasts. For more information, see
// the Canadian Broadcast Standards Council website.
@property (nonatomic, copy) NSString *catvRating;

// The video's Central Board of Film Certification (CBFC - India) rating.
@property (nonatomic, copy) NSString *cbfcRating;

// The video's Consejo de Calificación Cinematográfica (Chile) rating.
@property (nonatomic, copy) NSString *cccRating;

// The video's rating from Portugal's Comissão de Classificação de Espect´culos.
@property (nonatomic, copy) NSString *cceRating;

// The video's rating in Switzerland.
@property (nonatomic, copy) NSString *chfilmRating;

// The video's Canadian Home Video Rating System (CHVRS) rating.
@property (nonatomic, copy) NSString *chvrsRating;

// The video's rating from the Commission de Contrôle des Films (Belgium).
@property (nonatomic, copy) NSString *cicfRating;

// The video's rating from Romania's CONSILIUL NATIONAL AL AUDIOVIZUALULUI
// (CNA).
@property (nonatomic, copy) NSString *cnaRating;

// Rating system in France - Commission de classification cinematographique
@property (nonatomic, copy) NSString *cncRating;

// The video's rating from France's Conseil supérieur de l?audiovisuel, which
// rates broadcast content.
@property (nonatomic, copy) NSString *csaRating;

// The video's rating from Luxembourg's Commission de surveillance de la
// classification des films (CSCF).
@property (nonatomic, copy) NSString *cscfRating;

// The video's rating in the Czech Republic.
@property (nonatomic, copy) NSString *czfilmRating;

// The video's Departamento de Justiça, Classificação, Qualificação e Títulos
// (DJCQT - Brazil) rating.
@property (nonatomic, copy) NSString *djctqRating;

// Reasons that explain why the video received its DJCQT (Brazil) rating.
@property (nonatomic, retain) NSArray *djctqRatingReasons;  // of NSString

// Rating system in Turkey - Evaluation and Classification Board of the Ministry
// of Culture and Tourism
@property (nonatomic, copy) NSString *ecbmctRating;

// The video's rating in Estonia.
@property (nonatomic, copy) NSString *eefilmRating;

// The video's rating in Egypt.
@property (nonatomic, copy) NSString *egfilmRating;

// The video's Eirin (映倫) rating. Eirin is the Japanese rating system.
@property (nonatomic, copy) NSString *eirinRating;

// The video's rating from Malaysia's Film Censorship Board.
@property (nonatomic, copy) NSString *fcbmRating;

// The video's rating from Hong Kong's Office for Film, Newspaper and Article
// Administration.
@property (nonatomic, copy) NSString *fcoRating;

// This property has been deprecated. Use the
// contentDetails.contentRating.cncRating instead.
@property (nonatomic, copy) NSString *fmocRating;

// The video's rating from South Africa's Film and Publication Board.
@property (nonatomic, copy) NSString *fpbRating;

// The video's Freiwillige Selbstkontrolle der Filmwirtschaft (FSK - Germany)
// rating.
@property (nonatomic, copy) NSString *fskRating;

// The video's rating in Greece.
@property (nonatomic, copy) NSString *grfilmRating;

// The video's Instituto de la Cinematografía y de las Artes Audiovisuales (ICAA
// - Spain) rating.
@property (nonatomic, copy) NSString *icaaRating;

// The video's Irish Film Classification Office (IFCO - Ireland) rating. See the
// IFCO website for more information.
@property (nonatomic, copy) NSString *ifcoRating;

// The video's rating in Israel.
@property (nonatomic, copy) NSString *ilfilmRating;

// The video's INCAA (Instituto Nacional de Cine y Artes Audiovisuales -
// Argentina) rating.
@property (nonatomic, copy) NSString *incaaRating;

// The video's rating from the Kenya Film Classification Board.
@property (nonatomic, copy) NSString *kfcbRating;

// voor de Classificatie van Audiovisuele Media (Netherlands).
@property (nonatomic, copy) NSString *kijkwijzerRating;

// The video's Korea Media Rating Board (영상물등급위원회) rating. The KMRB rates videos
// in South Korea.
@property (nonatomic, copy) NSString *kmrbRating;

// The video's rating from Indonesia's Lembaga Sensor Film.
@property (nonatomic, copy) NSString *lsfRating;

// The video's rating from Malta's Film Age-Classification Board.
@property (nonatomic, copy) NSString *mccaaRating;

// The video's rating from the Danish Film Institute's (Det Danske Filminstitut)
// Media Council for Children and Young People.
@property (nonatomic, copy) NSString *mccypRating;

// The video's rating from Singapore's Media Development Authority (MDA) and,
// specifically, it's Board of Film Censors (BFC).
@property (nonatomic, copy) NSString *mdaRating;

// The video's rating from Medietilsynet, the Norwegian Media Authority.
@property (nonatomic, copy) NSString *medietilsynetRating;

// The video's rating from Finland's Kansallinen Audiovisuaalinen Instituutti
// (National Audiovisual Institute).
@property (nonatomic, copy) NSString *mekuRating;

// The video's rating from the Ministero dei Beni e delle Attività Culturali e
// del Turismo (Italy).
@property (nonatomic, copy) NSString *mibacRating;

// The video's Ministerio de Cultura (Colombia) rating.
@property (nonatomic, copy) NSString *mocRating;

// The video's rating from Taiwan's Ministry of Culture (文化部).
@property (nonatomic, copy) NSString *moctwRating;

// The video's Motion Picture Association of America (MPAA) rating.
@property (nonatomic, copy) NSString *mpaaRating;

// The video's rating from the Movie and Television Review and Classification
// Board (Philippines).
@property (nonatomic, copy) NSString *mtrcbRating;

// The video's rating in Poland.
@property (nonatomic, copy) NSString *nbcplRating;

// The video's rating from the Maldives National Bureau of Classification.
@property (nonatomic, copy) NSString *nbcRating;

// The video's rating from the Bulgarian National Film Center.
@property (nonatomic, copy) NSString *nfrcRating;

// The video's rating from Nigeria's National Film and Video Censors Board.
@property (nonatomic, copy) NSString *nfvcbRating;

// The video's rating from the Nacionãlais Kino centrs (National Film Centre of
// Latvia).
@property (nonatomic, copy) NSString *nkclvRating;

// The video's Office of Film and Literature Classification (OFLC - New Zealand)
// rating.
@property (nonatomic, copy) NSString *oflcRating;

// The video's rating in Peru.
@property (nonatomic, copy) NSString *pefilmRating;

// The video's rating from the Hungarian Nemzeti Filmiroda, the Rating Committee
// of the National Office of Film.
@property (nonatomic, copy) NSString *rcnofRating;

// The video's rating in Venezuela.
@property (nonatomic, copy) NSString *resorteviolenciaRating;

// The video's General Directorate of Radio, Television and Cinematography
// (Mexico) rating.
@property (nonatomic, copy) NSString *rtcRating;

// The video's rating from Ireland's Raidió Teilifís Éireann.
@property (nonatomic, copy) NSString *rteRating;

// The video's National Film Registry of the Russian Federation (MKRF - Russia)
// rating.
@property (nonatomic, copy) NSString *russiaRating;

// The video's rating in Slovakia.
@property (nonatomic, copy) NSString *skfilmRating;

// The video's rating in Iceland.
@property (nonatomic, copy) NSString *smaisRating;

// The video's rating from Statens medieråd (Sweden's National Media Council).
@property (nonatomic, copy) NSString *smsaRating;

// The video's TV Parental Guidelines (TVPG) rating.
@property (nonatomic, copy) NSString *tvpgRating;

// A rating that YouTube uses to identify age-restricted content.
@property (nonatomic, copy) NSString *ytRating;

@end
