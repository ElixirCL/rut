searchNodes=[{"doc":"A module that helps with validation and formatting of chilean RUT/RUN identifiers . Made by the Elixir Chile Community.","ref":"ElixirCLRut.html","title":"ElixirCLRut","type":"module"},{"doc":"Formats a string or Rut struct with the Rut format. Examples iex&gt; format ( &quot;1&quot; ) &quot;1-9&quot; iex&gt; format ( &quot;63009482&quot; , true ) &quot;6.300.948-2&quot; iex&gt; format ( &quot;63009482&quot; , dashed? : true , separator : &quot;,&quot; ) &quot;6,300,948-2&quot;","ref":"ElixirCLRut.html#format/2","title":"ElixirCLRut.format/2","type":"function"},{"doc":"When given a string it will return an ElixirCLRut.Struct Example iex&gt; from ( &quot;1-9&quot; ) % ElixirCLRut.Struct { checkdigit : &quot;9&quot; , dashed? : true , from : &quot;1-9&quot; , lastdigit : &quot;9&quot; , normalized : [ 1 ] , normalized_with_checkdigit : [ 1 , 9 ] }","ref":"ElixirCLRut.html#from/1","title":"ElixirCLRut.from/1","type":"function"},{"doc":"Performs a simple validation and returns the boolean result. true if is valid. Examples iex&gt; valid? ( &quot;1&quot; ) true iex&gt; valid? ( &quot;6300948-1&quot; ) false iex&gt; valid? ( from ( &quot;6300948-1&quot; ) ) false","ref":"ElixirCLRut.html#valid?/1","title":"ElixirCLRut.valid?/1","type":"function"},{"doc":"Executes the rut validations. Examples iex&gt; validate ( &quot;1&quot; ) . valid? true iex&gt; validate ( &quot;6300948-1&quot; ) . valid? false","ref":"ElixirCLRut.html#validate/1","title":"ElixirCLRut.validate/1","type":"function"},{"doc":"The Check Digit allows to verify if a RUT is correctly formed.","ref":"ElixirCLRut.CheckDigit.html","title":"ElixirCLRut.CheckDigit","type":"module"},{"doc":"Calculates the check digit following the modulo 11 algorithm. Receives a list of numbers. Examples iex&gt; get ( [ 2 , 2 , 2 , 8 , 2 , 5 , 0 ] ) &quot;6&quot;","ref":"ElixirCLRut.CheckDigit.html#get/1","title":"ElixirCLRut.CheckDigit.get/1","type":"function"},{"doc":"Removes the last item from the list. Used for cleaning up the check digit before the algorithm. Examples iex&gt; remove ( [ 2 , 2 , 2 , 8 , 2 , 5 , 0 , 6 ] ) [ 2 , 2 , 2 , 8 , 2 , 5 , 0 ]","ref":"ElixirCLRut.CheckDigit.html#remove/1","title":"ElixirCLRut.CheckDigit.remove/1","type":"function"},{"doc":"Cleans and give format to RUT strings.","ref":"ElixirCLRut.Formatter.html","title":"ElixirCLRut.Formatter","type":"module"},{"doc":"Removes all chars (except for numbers and letter K) from the RUT. Examples iex&gt; clean ( &quot;2228250-6&quot; ) &quot;22282506&quot; iex&gt; clean ( &quot;14.193.432-5&quot; ) &quot;141934325&quot;","ref":"ElixirCLRut.Formatter.html#clean/1","title":"ElixirCLRut.Formatter.clean/1","type":"function"},{"doc":"Adds dots to a list of rut characters. Examples iex&gt; dots ( [ 2 , 0 , 9 , 6 , 1 , 6 , 0 , 5 ] ) &quot;20.961.605&quot; iex&gt; dots ( [ 2 , 0 , 9 , 6 , 1 , 6 , 0 , 5 ] , &quot;,&quot; ) &quot;20,961,605&quot; iex&gt; dots ( [ 2 , 0 , 9 , 6 , 1 , 6 , 0 , 5 ] , &quot;,&quot; , 3 ) &quot;20,961,605&quot;","ref":"ElixirCLRut.Formatter.html#dots/3","title":"ElixirCLRut.Formatter.dots/3","type":"function"},{"doc":"Gives format to a normalized RUT. Examples iex&gt; format ( ElixirCLRut . from ( &quot;20961605-K&quot; ) ) &quot;20.961.605-K&quot;","ref":"ElixirCLRut.Formatter.html#format/2","title":"ElixirCLRut.Formatter.format/2","type":"function"},{"doc":"Transforms a RUT string to a list of numbers. Converts lowercase to uppercase. Examples iex&gt; normalize ( &quot;2228250-6&quot; ) [ 2 , 2 , 2 , 8 , 2 , 5 , 0 , 6 ] iex&gt; normalize ( &quot;14.193.432-5&quot; ) [ 1 , 4 , 1 , 9 , 3 , 4 , 3 , 2 , 5 ]","ref":"ElixirCLRut.Formatter.html#normalize/1","title":"ElixirCLRut.Formatter.normalize/1","type":"function"},{"doc":"A struct that holds information of the rut.","ref":"ElixirCLRut.Struct.html","title":"ElixirCLRut.Struct","type":"module"},{"doc":"Standarizes the input and returns a struct that contains the formatted values. This structure must be passed down to the validator function for checking if the RUT is valid.","ref":"ElixirCLRut.Struct.html#from/2","title":"ElixirCLRut.Struct.from/2","type":"function"},{"doc":"Token is a struct that is passed between validations. It enables an standarized way of passing down the information.","ref":"ElixirCLRut.Token.html","title":"ElixirCLRut.Token","type":"module"},{"doc":"Modifies the given Token struct and set the error identifier and valid? to be false.","ref":"ElixirCLRut.Token.html#error/2","title":"ElixirCLRut.Token.error/2","type":"function"},{"doc":"Initializes a Token struct with valid? true as the default value. This token is passed down between validation functions. Example iex&gt; from ( ElixirCLRut . from ( &quot;1-9&quot; ) ) % ElixirCLRut.Token { errors : [ ] , from : % ElixirCLRut.Struct { checkdigit : &quot;9&quot; , dashed? : true , from : &quot;1-9&quot; , lastdigit : &quot;9&quot; , normalized : [ 1 ] , normalized_with_checkdigit : [ 1 , 9 ] } , valid? : true }","ref":"ElixirCLRut.Token.html#from/1","title":"ElixirCLRut.Token.from/1","type":"function"},{"doc":"Stores different validation functions","ref":"ElixirCLRut.Validations.html","title":"ElixirCLRut.Validations","type":"module"},{"doc":"Receives a Token struct and validates checkdigit with lastdigit. If they are different it will add :wrong_checkdigit to the errors list.","ref":"ElixirCLRut.Validations.html#has_valid_checkdigit/1","title":"ElixirCLRut.Validations.has_valid_checkdigit/1","type":"function"},{"doc":"Optional validation. Receives a Token struct and validates the normalized length is above or equal to the given length. Defaults to length 2. Example iex&gt; ( ElixirCLRut . validate ( &quot;00-0&quot; ) |&gt; ElixirCLRut.Validations . length ( ) ) . valid? true iex&gt; ( ElixirCLRut . validate ( &quot;00-0&quot; ) |&gt; ElixirCLRut.Validations . length ( 3 ) ) . valid? false","ref":"ElixirCLRut.Validations.html#length/2","title":"ElixirCLRut.Validations.length/2","type":"function"},{"doc":"Optional validation. Receives a Token struct and validates that all chars are not jut zeroes. Example iex&gt; ( ElixirCLRut . validate ( &quot;00000000-0&quot; ) |&gt; not_all_zeroes ( ) ) . valid? false iex&gt; ( ElixirCLRut . validate ( &quot;00000001-9&quot; ) |&gt; not_all_zeroes ( ) ) . valid? true","ref":"ElixirCLRut.Validations.html#not_all_zeroes/1","title":"ElixirCLRut.Validations.not_all_zeroes/1","type":"function"},{"doc":"Receives a Token struct and counts the normalized array, if it's empty it will add :value_is_empty to the errors list.","ref":"ElixirCLRut.Validations.html#not_empty/1","title":"ElixirCLRut.Validations.not_empty/1","type":"function"},{"doc":"Provides simple validation helpers.","ref":"ElixirCLRut.Validator.html","title":"ElixirCLRut.Validator","type":"module"},{"doc":"Validates the ElixirCLRut.Struct with some default validations.","ref":"ElixirCLRut.Validator.html#validate/1","title":"ElixirCLRut.Validator.validate/1","type":"function"},{"doc":"A module that helps with validation and formatting of chilean RUT/RUN identifiers . Made by the Elixir Chile Community.","ref":"readme.html","title":"ElixirCLRut","type":"extras"},{"doc":"If available in Hex , the package can be installed by adding elixircl_rut to your list of dependencies in mix.exs : def deps do [ { :elixircl_rut , &quot;~&gt; 1.0.0&quot; } ] end Documentation can be generated with ExDoc and published on HexDocs . Once published, the docs can be found at https://hexdocs.pm/elixircl_rut .","ref":"readme.html#installation","title":"ElixirCLRut - Installation","type":"extras"},{"doc":"1. Definitions 1.1. “Contributor” means each individual or legal entity that creates , contributes to the creation of , or owns Covered Software . 1.2. “Contributor Version” means the combination of the Contributions of others ( if any ) used by a Contributor and that particular Contributor &#39; s Contribution . 1.3. “Contribution” means Covered Software of a particular Contributor . 1.4. “Covered Software” means Source Code Form to which the initial Contributor has attached the notice in Exhibit A , the Executable Form of such Source Code Form , and Modifications of such Source Code Form , in each case including portions thereof . 1.5. “Incompatible With Secondary Licenses” means (a) that the initial Contributor has attached the notice described in Exhibit B to the Covered Software; or (b) that the Covered Software was made available under the terms of version 1.1 or earlier of the License, but not also under the terms of a Secondary License. 1.6. “Executable Form” means any form of the work other than Source Code Form . 1.7. “Larger Work” means a work that combines Covered Software with other material , in a separate file or files , that is not Covered Software . 1.8. “License” means this document . 1.9. “Licensable” means having the right to grant , to the maximum extent possible , whether at the time of the initial grant or subsequently , any and all of the rights conveyed by this License . 1.10. “Modifications” means any of the following : (a) any file in Source Code Form that results from an addition to, deletion from, or modification of the contents of Covered Software; or (b) any new file in Source Code Form that contains any Covered Software. 1.11. “Patent Claims” of a Contributor means any patent claim ( s ) , including without limitation , method , process , and apparatus claims , in any patent Licensable by such Contributor that would be infringed , but for the grant of the License , by the making , using , selling , offering for sale , having made , import , or transfer of either its Contributions or its Contributor Version . 1.12. “Secondary License” means either the GNU General Public License , Version 2.0 , the GNU Lesser General Public License , Version 2.1 , the GNU Affero General Public License , Version 3.0 , or any later versions of those licenses . 1.13. “Source Code Form” means the form of the work preferred for making modifications . 1.14. “You” (or “Your”) means an individual or a legal entity exercising rights under this License . For legal entities , “ You ” includes any entity that controls , is controlled by , or is under common control with You . For purposes of this definition , “ control ” means * * ( a ) * * the power , direct or indirect , to cause the direction or management of such entity , whether by contract or otherwise , or * * ( b ) * * ownership of more than fifty percent ( 50 % ) of the outstanding shares or beneficial ownership of such entity . 2. License Grants and Conditions 2.1. Grants Each Contributor hereby grants You a world-wide, royalty-free, non-exclusive license: (a) under intellectual property rights (other than patent or trademark) Licensable by such Contributor to use, reproduce, make available, modify, display, perform, distribute, and otherwise exploit its Contributions, either on an unmodified basis, with Modifications, or as part of a Larger Work; and (b) under Patent Claims of such Contributor to make, use, sell, offer for sale, have made, import, and otherwise transfer either its Contributions or its Contributor Version. 2.2. Effective Date The licenses granted in Section 2.1 with respect to any Contribution become effective for each Contribution on the date the Contributor first distributes such Contribution. 2.3. Limitations on Grant Scope The licenses granted in this Section 2 are the only rights granted under this License. No additional rights or licenses will be implied from the distribution or licensing of Covered Software under this License. Notwithstanding Section 2.1(b) above, no patent license is granted by a Contributor: (a) for any code that a Contributor has removed from Covered Software; or (b) for infringements caused by: (i) Your and any other third party's modifications of Covered Software, or (ii) the combination of its Contributions with other software (except as part of its Contributor Version); or (c) under Patent Claims infringed by Covered Software in the absence of its Contributions. This License does not grant any rights in the trademarks, service marks, or logos of any Contributor (except as may be necessary to comply with the notice requirements in Section 3.4). 2.4. Subsequent Licenses No Contributor makes additional grants as a result of Your choice to distribute the Covered Software under a subsequent version of this License (see Section 10.2) or under the terms of a Secondary License (if permitted under the terms of Section 3.3). 2.5. Representation Each Contributor represents that the Contributor believes its Contributions are its original creation(s) or it has sufficient rights to grant the rights to its Contributions conveyed by this License. 2.6. Fair Use This License is not intended to limit any rights You have under applicable copyright doctrines of fair use, fair dealing, or other equivalents. 2.7. Conditions Sections 3.1, 3.2, 3.3, and 3.4 are conditions of the licenses granted in Section 2.1. 3. Responsibilities 3.1. Distribution of Source Form All distribution of Covered Software in Source Code Form, including any Modifications that You create or to which You contribute, must be under the terms of this License. You must inform recipients that the Source Code Form of the Covered Software is governed by the terms of this License, and how they can obtain a copy of this License. You may not attempt to alter or restrict the recipients' rights in the Source Code Form. 3.2. Distribution of Executable Form If You distribute Covered Software in Executable Form then: (a) such Covered Software must also be made available in Source Code Form, as described in Section 3.1, and You must inform recipients of the Executable Form how they can obtain a copy of such Source Code Form by reasonable means in a timely manner, at a charge no more than the cost of distribution to the recipient; and (b) You may distribute such Executable Form under the terms of this License, or sublicense it under different terms, provided that the license for the Executable Form does not attempt to limit or alter the recipients' rights in the Source Code Form under this License. 3.3. Distribution of a Larger Work You may create and distribute a Larger Work under terms of Your choice, provided that You also comply with the requirements of this License for the Covered Software. If the Larger Work is a combination of Covered Software with a work governed by one or more Secondary Licenses, and the Covered Software is not Incompatible With Secondary Licenses, this License permits You to additionally distribute such Covered Software under the terms of such Secondary License(s), so that the recipient of the Larger Work may, at their option, further distribute the Covered Software under the terms of either this License or such Secondary License(s). 3.4. Notices You may not remove or alter the substance of any license notices (including copyright notices, patent notices, disclaimers of warranty, or limitations of liability) contained within the Source Code Form of the Covered Software, except that You may alter any license notices to the extent required to remedy known factual inaccuracies. 3.5. Application of Additional Terms You may choose to offer, and to charge a fee for, warranty, support, indemnity or liability obligations to one or more recipients of Covered Software. However, You may do so only on Your own behalf, and not on behalf of any Contributor. You must make it absolutely clear that any such warranty, support, indemnity, or liability obligation is offered by You alone, and You hereby agree to indemnify every Contributor for any liability incurred by such Contributor as a result of warranty, support, indemnity or liability terms You offer. You may include additional disclaimers of warranty and limitations of liability specific to any jurisdiction. 4. Inability to Comply Due to Statute or Regulation If it is impossible for You to comply with any of the terms of this License with respect to some or all of the Covered Software due to statute, judicial order, or regulation then You must: (a) comply with the terms of this License to the maximum extent possible; and (b) describe the limitations and the code they affect. Such description must be placed in a text file included with all distributions of the Covered Software under this License. Except to the extent prohibited by statute or regulation, such description must be sufficiently detailed for a recipient of ordinary skill to be able to understand it. 5. Termination 5.1. The rights granted under this License will terminate automatically if You fail to comply with any of its terms. However, if You become compliant, then the rights granted under this License from a particular Contributor are reinstated (a) provisionally, unless and until such Contributor explicitly and finally terminates Your grants, and (b) on an ongoing basis, if such Contributor fails to notify You of the non-compliance by some reasonable means prior to 60 days after You have come back into compliance. Moreover, Your grants from a particular Contributor are reinstated on an ongoing basis if such Contributor notifies You of the non-compliance by some reasonable means, this is the first time You have received notice of non-compliance with this License from such Contributor, and You become compliant prior to 30 days after Your receipt of the notice. 5.2. If You initiate litigation against any entity by asserting a patent infringement claim (excluding declaratory judgment actions, counter-claims, and cross-claims) alleging that a Contributor Version directly or indirectly infringes any patent, then the rights granted to You by any and all Contributors for the Covered Software under Section 2.1 of this License shall terminate. 5.3. In the event of termination under Sections 5.1 or 5.2 above, all end user license agreements (excluding distributors and resellers) which have been validly granted by You or Your distributors under this License prior to termination shall survive termination. 6. Disclaimer of Warranty Covered Software is provided under this License on an “as is” basis, without warranty of any kind, either expressed, implied, or statutory, including, without limitation, warranties that the Covered Software is free of defects, merchantable, fit for a particular purpose or non-infringing. The entire risk as to the quality and performance of the Covered Software is with You. Should any Covered Software prove defective in any respect, You (not any Contributor) assume the cost of any necessary servicing, repair, or correction. This disclaimer of warranty constitutes an essential part of this License. No use of any Covered Software is authorized under this License except under this disclaimer. 7. Limitation of Liability Under no circumstances and under no legal theory, whether tort (including negligence), contract, or otherwise, shall any Contributor, or anyone who distributes Covered Software as permitted above, be liable to You for any direct, indirect, special, incidental, or consequential damages of any character including, without limitation, damages for lost profits, loss of goodwill, work stoppage, computer failure or malfunction, or any and all other commercial damages or losses, even if such party shall have been informed of the possibility of such damages. This limitation of liability shall not apply to liability for death or personal injury resulting from such party's negligence to the extent applicable law prohibits such limitation. Some jurisdictions do not allow the exclusion or limitation of incidental or consequential damages, so this exclusion and limitation may not apply to You. 8. Litigation Any litigation relating to this License may be brought only in the courts of a jurisdiction where the defendant maintains its principal place of business and such litigation shall be governed by laws of that jurisdiction, without reference to its conflict-of-law provisions. Nothing in this Section shall prevent a party's ability to bring cross-claims or counter-claims. 9. Miscellaneous This License represents the complete agreement concerning the subject matter hereof. If any provision of this License is held to be unenforceable, such provision shall be reformed only to the extent necessary to make it enforceable. Any law or regulation which provides that the language of a contract shall be construed against the drafter shall not be used to construe this License against a Contributor. 10. Versions of the License 10.1. New Versions Mozilla Foundation is the license steward. Except as provided in Section 10.3, no one other than the license steward has the right to modify or publish new versions of this License. Each version will be given a distinguishing version number. 10.2. Effect of New Versions You may distribute the Covered Software under the terms of the version of the License under which You originally received the Covered Software, or under the terms of any subsequent version published by the license steward. 10.3. Modified Versions If you create software not governed by this License, and you want to create a new license for such software, you may create and use a modified version of this License if you rename the license and remove any references to the name of the license steward (except to note that such modified license differs from this License). 10.4. Distributing Source Code Form that is Incompatible With Secondary Licenses If You choose to distribute Source Code Form that is Incompatible With Secondary Licenses under the terms of this version of the License, the notice described in Exhibit B of this License must be attached.","ref":"license.html","title":"Mozilla Public License Version 2.0","type":"extras"},{"doc":"This Source Code Form is subject to the terms of the Mozilla Public License , v . 2.0 . If a copy of the MPL was not distributed with this file , You can obtain one at http :// mozilla . org / MPL / 2.0 / . If it is not possible or desirable to put the notice in a particular file, then You may include the notice in a location (such as a LICENSE file in a relevant directory) where a recipient would be likely to look for such a notice. You may add additional accurate notices of copyright ownership.","ref":"license.html#exhibit-a-source-code-form-license-notice","title":"Mozilla Public License Version 2.0 - Exhibit A - Source Code Form License Notice","type":"extras"},{"doc":"This Source Code Form is &quot;Incompatible With Secondary Licenses&quot; , as defined by the Mozilla Public License , v . 2.0 .","ref":"license.html#exhibit-b-incompatible-with-secondary-licenses-notice","title":"Mozilla Public License Version 2.0 - Exhibit B - “Incompatible With Secondary Licenses” Notice","type":"extras"},{"doc":"All notable changes to this project will be documented in this file. The format is based on Keep a Changelog , and this project adheres to Romantic Versioning .","ref":"changelog.html","title":"Changelog","type":"extras"},{"doc":"Features Can Format a RUT/RUN value. Can Validate a RUT/RUN value.","ref":"changelog.html#1-0-0-2022-03-30","title":"Changelog - 1.0.0 - 2022-03-30","type":"extras"},{"doc":"","ref":"examples.html","title":"ElixirCLRut Examples","type":"extras"},{"doc":"Mix . install ( [ { :elixircl_rut , git : &quot;https://github.com/ElixirCL/rut.git&quot; , branch : &quot;main&quot; } ] )","ref":"examples.html#installation","title":"ElixirCLRut Examples - Installation","type":"extras"},{"doc":"Custom Validations are used when you need to specify stricter rules than just the normal algorithm validations. defmodule CustomValidations do alias ElixirCLRut.Token def length_above_3 ( input ) do # fun fact: the person with the lowest rut is 10-8 case Enum . count ( input . from . normalized ) &lt; 3 do true -&gt; Token . error ( input , :length_less_than_3 ) false -&gt; input end end def not_all_zeroes ( input ) do # get all the zeroes zeroes = Enum . filter ( input . from . normalized , &amp; ( &amp;1 == 0 ) ) # if we have all zeroes then is not valid case zeroes == input . from . normalized do true -&gt; Token . error ( input , :all_zeroes ) false -&gt; input end end end ElixirCLRut . validate ( &quot;0-0&quot; ) |&gt; CustomValidations . length_above_3 ( ) |&gt; CustomValidations . not_all_zeroes ( )","ref":"examples.html#custom-validations","title":"ElixirCLRut Examples - Custom Validations","type":"extras"},{"doc":"If you are happy with the standard validations you can use the quick function valid? that will return just a boolean ElixirCLRut . valid? ( &quot;1-9&quot; )","ref":"examples.html#valid","title":"ElixirCLRut Examples - valid?","type":"extras"},{"doc":"You can quickly get the format. This will append the correct digit if not available. # &quot;6.300.948-2&quot; ElixirCLRut . format ( &quot;6,3.0.0,9.48....&quot; ) You can specify if the rut has the check digit by using format/2 or dashing the digit. # &quot;6.300.948-2&quot; ElixirCLRut . format ( &quot;6300948-2&quot; ) ElixirCLRut . format ( &quot;63009482&quot; , true ) You can also specify if the rut has the check digit by using dashed?:true and the separator character by passing separator: params. # &quot;6,300,948-2&quot; ElixirCLRut . format ( &quot;63009482&quot; , dashed? :true , separator : &quot;,&quot; )","ref":"examples.html#format","title":"ElixirCLRut Examples - format","type":"extras"},{"doc":"You can get the check digit creating the struct ElixirCLRut . from ( &quot;6300948&quot; ) . checkdigit","ref":"examples.html#from","title":"ElixirCLRut Examples - from","type":"extras"},{"doc":"ElixirCLRut was originally written by Camilo Castro and is currently developed and maintained by Elixir Chile . ElixirCLRut is a collective work with contributions from many people, including: Camilo Castro (@clsource) Matías Reyes (@matreyes) Benjamín Silva Cristían Arenas (@ninoscript) Thanks!","ref":"authors.html","title":"ElixirCLRut Authors","type":"extras"}]