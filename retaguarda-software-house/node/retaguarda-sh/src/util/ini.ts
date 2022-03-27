/********************************************************************************
Title: T2Ti ERP Fenix
Description: Manipula arquivo INI

The MIT License

Copyright: Copyright (C) 2020 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           t2ti.com@gmail.com

@author T2Ti.COM
@version 1.0

Original: https://github.com/galangel/easy-ini
********************************************************************************/
const   _EMPTY_LINE = 0,
        _HASH_COMMENT = 1,
        _BREAK_COMMENT = 2,
        _SECTION = 3,
        _PAIR = 4,
        _GARBAGE = 5,
        _ACBR_OK = 6,
        _ACBR_ERRO = 7

export class Ini {

    origin: string;
    autoTrim: boolean;
    eol: any;
    _defSecName: any;
    _typeScheme: any;
    _lineGens = [];
    _types = [];
    iniData = [];

    constructor(str, {defaultSectionName = 'DEFAULT_SECTION!', eol = require('os').EOL, autoTrim = true} =  {defaultSectionName: 'DEFAULT_SECTION!', eol: require('os').EOL, autoTrim: true}) {
        this.origin = str
        this.autoTrim = autoTrim
        this.eol = eol
        this._defSecName = defaultSectionName
        this._typeScheme = [
            {'key': () => '', 'val': () => null},
            {'key': l => l, 'val': () => null},
            {'key': l => l, 'val': () => null},
            {'key': l => l, 'val': () => null},
            {'key': l => l.split('=')[0], 'val': l => l.split(/=(.*)/)[1]},
            {'key': l => l, 'val': () => null},
            {'key': () => 'OK', 'val': l => l},
            {'key': () => 'ERRO', 'val': l => l}
        ]
        this._lineGens = [   //line, trim ,clean(comment garbage)
            () => '',
            (l,t) => t ? l.key.trim() : l.key,
            (l,t) => t ? l.key.trim() : l.key,
            (l,t) => t ? l.key.trim() : l.key,
            (l,t) => t ? `${l.key.trim()}=${l.val.trim()}` : `${l.key}=${l.val}`,
            (l,t,c) => c ? `;${t ? l.key.trim() : l.key}` : `${t ? l.key.trim() : l.key}`,
            (l,t) => t ? `${l.key.trim()}=${l.val.trim()}` : `${l.key}=${l.val}`,
            (l,t) => t ? `${l.key.trim()}=${l.val.trim()}` : `${l.key}=${l.val}`
        ]
        this._types = [
            v => v.match(/^\s*$/) != null,              //     0: 'emptyLine',
            v => v.match(/^ *#/) != null,               //     1: 'hashcomment',
            v => v.match(/^ *;/) != null,               //     2: 'breakcomment',
            v => v.match(/^\s*\[.*\]$/) != null,        //     3: 'section',
            v => v.match(/^\s*([^#;]*\w+)=/) != null,   //     4: 'pair',
            v => v.match(/^([^=#;]+\w$)/) != null,      //     5: 'garbage'
            v => v.match(/^ *OK/) != null,              //     6: 'OK-ACBr',
            v => v.match(/^ *ERRO/) != null,            //     7: 'ERRO-ACBr',
        ]
        this.iniData = this._createINIData(this.origin)
    }
    _findType(line) {
        for (let t in this._types) {
            if (this._types[t](line)) {
                return parseInt(t)
            }
        }
    }

    _addByType(obj, type, key = '', val = '') {
        if (type == _SECTION) {obj.push({name: key, content: []})} else {
            obj[obj.length -1].content.push({type, key, val})
        }
    }

    _createINIData(string) {
        const iniData = []
        const lines = string.split(this.eol)
        if (this._findType(lines[0]) != _SECTION) {
            iniData.push({name: this._defSecName, content: []})
        }
        for (let l of lines) {
            if (this.autoTrim) {l = l.trim()}
            const lineType = this._findType(l)
            try{
                this._addByType(iniData, lineType, this._typeScheme[lineType].key(l), this._typeScheme[lineType].val(l))
            } catch (e) {
                console.log(l,e)
                throw e
            }
        }
        return iniData
    }

    createINIString({shouldTrim = false, shouldFix = false, cleanHashComments = false, cleanBreakComment = false, cleanEmptyLines = false, noEmptySections = false, noSections = false} =
        {shouldTrim: false, shouldFix: false, cleanHashComments: false, cleanBreakComment: false, cleanEmptyLines: false, noEmptySections: false, noSections: false}) {
        let output = '', curLine = ''
        for (const section of this.iniData) {
            let sectionString = '', contentString = ''
            if (section.name != this._defSecName && !noSections) {
                sectionString += cleanEmptyLines ? this.eol : ''
                sectionString += shouldTrim ? `${section.name.trim()}${this.eol}` : `${section.name}${this.eol}`
            }
            for (const l of section.content) {
                curLine = this._lineGens[l.type](l, shouldTrim, shouldFix)
                if (cleanEmptyLines && this._findType(curLine) == _EMPTY_LINE) {continue}
                if (cleanHashComments && this._findType(curLine) == _HASH_COMMENT) {continue}
                if (cleanBreakComment && this._findType(curLine) == _BREAK_COMMENT) {continue}
                contentString += `${curLine}${this.eol}`
            }
            if (noEmptySections && contentString == '') {continue}
            output += sectionString + contentString
        }
        return output
    }

    createSimpleObject(includeTypes = [4]) {
        const result = {}
        for (const sec of this.iniData) {
            let ref = includeTypes.includes(3) && sec.name != this._defSecName ? result[sec.name] = {} : result
            for (const line of sec.content) {
                if(includeTypes.includes(line.type)) {
                    ref[line.key] = line.val
                }
            }
        }
        return result
    }

    getKeyIfExists(inputKey) {
        for (const sec of this.iniData) {
            for (const line of sec.content) {
                if (line.type == _PAIR && line.key.trim() == inputKey.trim()) {
                    return line
                }
            }
        }
        return null
    }

    findAndChangeKeyIfExists(inputKey, inputValue = '') {
        const res = this.getKeyIfExists(inputKey)
        if (res) {
            res.val = inputValue
            return true
        }
        return false
    }

    findAndRemoveKeyIfExists(inputKey) {
        for (const sec of this.iniData) {
            for (const [index, line] of sec.content.entries()) {
                if (line.type == _PAIR && line.key.trim() == inputKey.trim()) {
                    sec.content.splice(index, 1)
                    return true
                }
            }
        }
        return false
    }

    removeEverythingButSections(sections = [], partialMatch = false) {
        for (const [index, section] of this.iniData.entries()) {
            if (sections.includes(section.name)
            || (partialMatch && sections.filter(a => section.name.indexOf(a) >= 0).length > 0)) {
                continue
            } else {
                this.iniData.splice(index, 1)
                return this.removeEverythingButSections(sections, partialMatch)
            }
        }
        return true
    }

    findAndRemoveSectionIfExists(sectionName, partialMatch = false) {
        for (const [index, section] of this.iniData.entries()) {
            if (!partialMatch && section.name == sectionName ||
                partialMatch && section.name.indexOf(sectionName) >= 0) {
                this.iniData.splice(index, 1)
                return true
            }
        }
        return false
    }

    putStringInSection(string, sectionName = this._defSecName) {
        let existingSec = false, valueAdded = false
        const stringType = this._findType(string)
        const stringObj = {
            type: stringType,
            key: this._typeScheme[stringType].key(string),
            val: this._typeScheme[stringType].val(string)
        }
        for (const sec of this.iniData) {
            if (sectionName == sec.name.trim()) {
                for (const line of sec.content) {
                    if (line.key == stringObj.key && stringObj.type == _PAIR) {
                        line.val = stringObj.val
                        valueAdded = true
                        break
                    }
                }
                if (!valueAdded) {
                    sec.content.push(stringObj)
                    existingSec = true
                    break
                }
            }
        }
        if (!existingSec && !valueAdded) {
            if (sectionName == this._defSecName) {
                this.iniData.unshift({name: sectionName, content: []})
            } else {
                this.iniData.push({name: sectionName, content: []})
            }
            return this.putStringInSection(string, sectionName)
        }
        return true
    }

    getLinesByMatch(token) {
        const resultLines = []
        for (const sec of this.iniData) {
            for (const line of sec.content) {
                if (line.type == _PAIR) {
                    if (line.val.indexOf(token) >= 0 || line.key.indexOf(token) >= 0) {
                        resultLines.push(this._lineGens[line.type](line))
                        continue
                    }
                }
                if (line.key.indexOf(token) >= 0) {
                    resultLines.push(this._lineGens[line.type](line))
                    continue
                }
            }
        }
        return resultLines
    }

    removeLineByMatch(token, global = false, _done = false) {
        for (const sec of this.iniData) {
            for (const [index, line] of sec.content.entries()) {
                if (line.type == _PAIR) {
                    if (line.val.indexOf(token) >= 0 || line.key.indexOf(token) >= 0) {
                        sec.content.splice(index, 1)
                        if (global) {return this.removeLineByMatch(token, global, true)}
                        else {_done = true; break}
                    }
                }
                if (line.key.indexOf(token) >= 0) {
                    sec.content.splice(index, 1)
                    if (global) {return this.removeLineByMatch(token, global, true)}
                    else {_done = true; break}
                }
            }
        }
        return _done
    }

    findAndReplace(token, value = '', global = false, _done = false) {
        for (const sec of this.iniData) {
            for (const line of sec.content) {
                if (line.type == _PAIR) {
                    if (line.val.indexOf(token) >= 0) {
                        line.val = line.val.replace(token, value)
                        if (global) {return this.findAndReplace(token, value, global, true)}
                        else {_done = true; break}
                    }
                }
                if (line.key.indexOf(token) >= 0) {
                    line.key = line.key.replace(token, value)
                    if (global) {return this.findAndReplace(token, value, global, true)}
                    else {_done = true; break}
                }
            }
        }
        return _done
    }

    solveDuplicates(preferFirstOccurrence = false) {
        for (const sec of this.iniData) {
            for (const [index, line] of sec.content.entries()) {
                if (line.type == _PAIR) {
                    if (preferFirstOccurrence) {
                        const tempKey = line.key
                        line.key = 'TeMpKeY'
                        while (this.findAndRemoveKeyIfExists(tempKey)) {}
                        line.key = tempKey
                    } else {
                        const tempKey = line.key
                        line.key = 'TeMpKeY'
                        if (this.getKeyIfExists(tempKey)) {
                            sec.content.splice(index, 1)
                            return this.solveDuplicates(preferFirstOccurrence)
                        } else {
                            line.key = tempKey
                        }
                    }
                }
            }
        }
        return true
    }

    // solveSelfReferences(prefix, suffix) {
    //     const refReg = new RegExp(`${prefix}(.*?)${suffix}`, ['g'])
    //     let result = false
    //     for (const sec of this.iniData) {
    //         for (const line of sec.content) {
    //             if (line.type == _PAIR) {
    //                 const matchRes = line.val.match(refReg)
    //                 if (matchRes && matchRes.length > 0) {
    //                     for (const match of matchRes) {
    //                         const suspect = this.getKeyIfExists(match.replace(prefix, '').replace(suffix, ''))
    //                         if (suspect && suspect.val) {
    //                             line.val = line.val.replace(match, suspect.val)
    //                             result = true
    //                         }
    //                     }
    //                 }
    //             } else {
    //                 const matchRes = line.key.match(refReg)
    //                 if (matchRes && matchRes.length > 0) {
    //                     for (const match of matchRes) {
    //                         const suspect = this.getKeyIfExists(match.replace(prefix, '').replace(suffix, ''))
    //                         if (suspect && suspect.val) {
    //                             line.key = line.key.replace(match, suspect.val)
    //                             result = true
    //                         }
    //                     }
    //                 }
    //             }
    //         }
    //     }
    //     if (result) {return this.solveSelfReferences(prefix, suffix)}
    //     return true
    // }

    mergeWith(anotherINIObject, before = false) {
        const otherINIData = anotherINIObject.iniData
        let sectionFound
        for (const s2 of otherINIData) {
            sectionFound = false
            for (const s of this.iniData) {
                if (s2.name == s.name) {
                    if (before) {s.content.unshift(...s2.content.map(a => ({...a})))}
                    else {s.content.push(...s2.content.map(a => ({...a})))}
                    sectionFound = true
                    break
                }
            }
            if (!sectionFound) {
                if (before) {
                    const index = this.iniData[0].name == this._defSecName ? 1 : 0
                    this.iniData.splice(index, 0, {name: s2.name, content: []});
                    this.iniData[index].content.push(...s2.content.map(a => ({...a})))
                } else {
                    this.iniData.push({name: s2.name, content: []})
                    this.iniData[this.iniData.length -1].content.push(...s2.content.map(a => ({...a})))
                }
            }
        }
        return true
    }
}