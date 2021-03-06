i;8;CPData.ji;9;CPCoder.ji;9;CPArray.ji;10;CPString.ji;10;CPNumber.ji;14;CPDictionary.ji;9;CPValue.jc;15109;
var CPArchiverReplacementClassNames = nil;
var _CPKeyedArchiverDidEncodeObjectSelector = 1,
    _CPKeyedArchiverWillEncodeObjectSelector = 2,
    _CPKeyedArchiverWillReplaceObjectWithObjectSelector = 4,
    _CPKeyedArchiverDidFinishSelector = 8,
    _CPKeyedArchiverWillFinishSelector = 16;
var _CPKeyedArchiverNullString = "$null",
    _CPKeyedArchiverNullReference = nil,
    _CPKeyedArchiverUIDKey = "CP$UID",
    _CPKeyedArchiverTopKey = "$top",
    _CPKeyedArchiverObjectsKey = "$objects",
    _CPKeyedArchiverArchiverKey = "$archiver",
    _CPKeyedArchiverVersionKey = "$version",
    _CPKeyedArchiverClassNameKey = "$classname",
    _CPKeyedArchiverClassesKey = "$classes",
    _CPKeyedArchiverClassKey = "$class";
var _CPKeyedArchiverStringClass = Nil,
    _CPKeyedArchiverNumberClass = Nil;
{var the_class = objj_allocateClassPair(CPValue, "_CPKeyedArchiverValue"),
meta_class = the_class.isa;objj_registerClassPair(the_class);
objj_addClassForBundle(the_class, objj_getBundleWithPath(OBJJ_CURRENT_BUNDLE.path));
}
{var the_class = objj_allocateClassPair(CPCoder, "CPKeyedArchiver"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_delegate"), new objj_ivar("_delegateSelectors"), new objj_ivar("_data"), new objj_ivar("_objects"), new objj_ivar("_UIDs"), new objj_ivar("_conditionalUIDs"), new objj_ivar("_replacementObjects"), new objj_ivar("_replacementClassNames"), new objj_ivar("_plistObject"), new objj_ivar("_plistObjects"), new objj_ivar("_outputFormat")]);
objj_registerClassPair(the_class);
objj_addClassForBundle(the_class, objj_getBundleWithPath(OBJJ_CURRENT_BUNDLE.path));
class_addMethods(the_class, [new objj_method(sel_getUid("initForWritingWithMutableData:"), function(self, _cmd, data)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPCoder") }, "init");
    if (self)
    {
        _data = data;
        _objects = [];
        _UIDs = objj_msgSend(CPDictionary, "dictionary");
        _conditionalUIDs = objj_msgSend(CPDictionary, "dictionary");
        _replacementObjects = objj_msgSend(CPDictionary, "dictionary");
        _data = data;
        _plistObject = objj_msgSend(CPDictionary, "dictionary");
        _plistObjects = objj_msgSend(CPArray, "arrayWithObject:", _CPKeyedArchiverNullString);
    }
    return self;
}
}), new objj_method(sel_getUid("finishEncoding"), function(self, _cmd)
{ with(self)
{
    if (_delegate && _delegateSelectors & _CPKeyedArchiverWillFinishSelector)
        objj_msgSend(_delegate, "archiverWillFinish:", self);
    var i = 0,
        topObject = _plistObject,
        classes = [];
    for (; i < _objects.length; ++i)
    {
        var object = _objects[i],
            theClass = objj_msgSend(object, "classForKeyedArchiver");
        _plistObject = _plistObjects[objj_msgSend(_UIDs, "objectForKey:", objj_msgSend(object, "hash"))];
        objj_msgSend(object, "encodeWithCoder:", self);
        if (_delegate && _delegateSelectors & _CPKeyedArchiverDidEncodeObjectSelector)
            objj_msgSend(_delegate, "archiver:didEncodeObject:", self, object);
    }
    _plistObject = objj_msgSend(CPDictionary, "dictionary");
    objj_msgSend(_plistObject, "setObject:forKey:", topObject, _CPKeyedArchiverTopKey);
    objj_msgSend(_plistObject, "setObject:forKey:", _plistObjects, _CPKeyedArchiverObjectsKey);
    objj_msgSend(_plistObject, "setObject:forKey:", objj_msgSend(self, "className"), _CPKeyedArchiverArchiverKey);
    objj_msgSend(_plistObject, "setObject:forKey:", "100000", _CPKeyedArchiverVersionKey);
    objj_msgSend(_data, "setPlistObject:", _plistObject);
    if (_delegate && _delegateSelectors & _CPKeyedArchiverDidFinishSelector)
        objj_msgSend(_delegate, "archiverDidFinish:", self);
}
}), new objj_method(sel_getUid("outputFormat"), function(self, _cmd)
{ with(self)
{
    return _outputFormat;
}
}), new objj_method(sel_getUid("setOutputFormat:"), function(self, _cmd, aPropertyListFormat)
{ with(self)
{
    _outputFormat = aPropertyListFormat;
}
}), new objj_method(sel_getUid("encodeBool:forKey:"), function(self, _cmd, aBOOL, aKey)
{ with(self)
{
    objj_msgSend(_plistObject, "setObject:forKey:", _CPKeyedArchiverEncodeObject(self, aBOOL, NO), aKey);
}
}), new objj_method(sel_getUid("encodeDouble:forKey:"), function(self, _cmd, aDouble, aKey)
{ with(self)
{
    objj_msgSend(_plistObject, "setObject:forKey:", _CPKeyedArchiverEncodeObject(self, aDouble, NO), aKey);
}
}), new objj_method(sel_getUid("encodeFloat:forKey:"), function(self, _cmd, aFloat, aKey)
{ with(self)
{
    objj_msgSend(_plistObject, "setObject:forKey:", _CPKeyedArchiverEncodeObject(self, aFloat, NO), aKey);
}
}), new objj_method(sel_getUid("encodeInt:forKey:"), function(self, _cmd, anInt, aKey)
{ with(self)
{
    objj_msgSend(_plistObject, "setObject:forKey:", _CPKeyedArchiverEncodeObject(self, anInt, NO), aKey);
}
}), new objj_method(sel_getUid("setDelegate:"), function(self, _cmd, aDelegate)
{ with(self)
{
    _delegate = aDelegate;
    if (objj_msgSend(_delegate, "respondsToSelector:", sel_getUid("archiver:didEncodeObject:")))
        _delegateSelectors |= _CPKeyedArchiverDidEncodeObjectSelector;
    if (objj_msgSend(_delegate, "respondsToSelector:", sel_getUid("archiver:willEncodeObject:")))
        _delegateSelectors |= _CPKeyedArchiverWillEncodeObjectSelector;
    if (objj_msgSend(_delegate, "respondsToSelector:", sel_getUid("archiver:willReplaceObject:withObject:")))
        _delegateSelectors |= _CPKeyedArchiverWillReplaceObjectWithObjectSelector;
    if (objj_msgSend(_delegate, "respondsToSelector:", sel_getUid("archiver:didFinishEncoding:")))
        _delegateSelectors |= _CPKeyedArchiverDidFinishEncodingSelector;
    if (objj_msgSend(_delegate, "respondsToSelector:", sel_getUid("archiver:willFinishEncoding:")))
        _delegateSelectors |= _CPKeyedArchiverWillFinishEncodingSelector;
}
}), new objj_method(sel_getUid("delegate"), function(self, _cmd)
{ with(self)
{
    return _delegate;
}
}), new objj_method(sel_getUid("encodePoint:forKey:"), function(self, _cmd, aPoint, aKey)
{ with(self)
{
    objj_msgSend(_plistObject, "setObject:forKey:", _CPKeyedArchiverEncodeObject(self, CPStringFromPoint(aPoint), NO), aKey);
}
}), new objj_method(sel_getUid("encodeRect:forKey:"), function(self, _cmd, aRect, aKey)
{ with(self)
{
    objj_msgSend(_plistObject, "setObject:forKey:", _CPKeyedArchiverEncodeObject(self, CPStringFromRect(aRect), NO), aKey);
}
}), new objj_method(sel_getUid("encodeSize:forKey:"), function(self, _cmd, aSize, aKey)
{ with(self)
{
    objj_msgSend(_plistObject, "setObject:forKey:", _CPKeyedArchiverEncodeObject(self, CPStringFromSize(aSize), NO), aKey);
}
}), new objj_method(sel_getUid("encodeConditionalObject:forKey:"), function(self, _cmd, anObject, aKey)
{ with(self)
{
    objj_msgSend(_plistObject, "setObject:forKey:", _CPKeyedArchiverEncodeObject(self, anObject, YES), aKey);
}
}), new objj_method(sel_getUid("encodeNumber:forKey:"), function(self, _cmd, aNumber, aKey)
{ with(self)
{
    objj_msgSend(_plistObject, "setObject:forKey:", _CPKeyedArchiverEncodeObject(self, aNumber, NO), aKey);
}
}), new objj_method(sel_getUid("encodeObject:forKey:"), function(self, _cmd, anObject, aKey)
{ with(self)
{
    objj_msgSend(_plistObject, "setObject:forKey:", _CPKeyedArchiverEncodeObject(self, anObject, NO), aKey);
}
}), new objj_method(sel_getUid("_encodeArrayOfObjects:forKey:"), function(self, _cmd, objects, aKey)
{ with(self)
{
    var i = 0,
        count = objects.length,
        references = objj_msgSend(CPArray, "arrayWithCapacity:", count);
    for (; i < count; ++i)
        objj_msgSend(references, "addObject:", _CPKeyedArchiverEncodeObject(self, objects[i], NO));
    objj_msgSend(_plistObject, "setObject:forKey:", references, aKey);
}
}), new objj_method(sel_getUid("_encodeDictionaryOfObjects:forKey:"), function(self, _cmd, aDictionary, aKey)
{ with(self)
{
    var key,
        keys = objj_msgSend(aDictionary, "keyEnumerator"),
        references = objj_msgSend(CPDictionary, "dictionary");
    while (key = objj_msgSend(keys, "nextObject"))
        objj_msgSend(references, "setObject:forKey:", _CPKeyedArchiverEncodeObject(self, objj_msgSend(aDictionary, "objectForKey:", key), NO), key);
    objj_msgSend(_plistObject, "setObject:forKey:", references, aKey);
}
}), new objj_method(sel_getUid("setClassName:forClass:"), function(self, _cmd, aClassName, aClass)
{ with(self)
{
    if (!_replacementClassNames)
        _replacementClassNames = objj_msgSend(CPDictionary, "dictionary");
    objj_msgSend(_replacementClassNames, "setObject:forKey:", aClassName, CPStringFromClass(aClass));
}
}), new objj_method(sel_getUid("classNameForClass:"), function(self, _cmd, aClass)
{ with(self)
{
    if (!_replacementClassNames)
        return aClass.name;
    var className = objj_msgSend(_replacementClassNames, "objectForKey:", CPStringFromClass(aClassName));
    return className ? className : aClass.name;
}
})]);
class_addMethods(meta_class, [new objj_method(sel_getUid("initialize"), function(self, _cmd)
{ with(self)
{
    if (self != objj_msgSend(CPKeyedArchiver, "class"))
        return;
    _CPKeyedArchiverStringClass = objj_msgSend(CPString, "class");
    _CPKeyedArchiverNumberClass = objj_msgSend(CPNumber, "class");
    _CPKeyedArchiverNullReference = objj_msgSend(CPDictionary, "dictionaryWithObject:forKey:", 0, _CPKeyedArchiverUIDKey);
}
}), new objj_method(sel_getUid("allowsKeyedCoding"), function(self, _cmd)
{ with(self)
{
    return YES;
}
}), new objj_method(sel_getUid("archivedDataWithRootObject:"), function(self, _cmd, anObject)
{ with(self)
{
    var data = objj_msgSend(CPData, "dataWithPlistObject:", nil),
        archiver = objj_msgSend(objj_msgSend(self, "alloc"), "initForWritingWithMutableData:", data);
    objj_msgSend(archiver, "encodeObject:forKey:", anObject, "root");
    objj_msgSend(archiver, "finishEncoding");
    return data;
}
}), new objj_method(sel_getUid("setClassName:forClass:"), function(self, _cmd, aClassName, aClass)
{ with(self)
{
    if (!CPArchiverReplacementClassNames)
        CPArchiverReplacementClassNames = objj_msgSend(CPDictionary, "dictionary");
    objj_msgSend(CPArchiverReplacementClassNames, "setObject:forKey:", aClassName, CPStringFromClass(aClass));
}
}), new objj_method(sel_getUid("classNameForClass:"), function(self, _cmd, aClass)
{ with(self)
{
    if (!CPArchiverReplacementClassNames)
        return aClass.name;
    var className = objj_msgSend(CPArchiverReplacementClassNames, "objectForKey:", CPStringFromClass(aClassName));
    return className ? className : aClass.name;
}
})]);
}
var _CPKeyedArchiverEncodeObject = function(self, anObject, isConditional)
{
    if (anObject !== nil && !anObject.isa)
        anObject = objj_msgSend(_CPKeyedArchiverValue, "valueWithJSObject:", anObject);
    var hash = objj_msgSend(anObject, "hash"),
        object = objj_msgSend(self._replacementObjects, "objectForKey:", hash);
    if (object === nil)
    {
        object = objj_msgSend(anObject, "replacementObjectForKeyedArchiver:", self);
        if (self._delegate)
        {
            if (object !== anObject && self._delegateSelectors & _CPKeyedArchiverWillReplaceObjectWithObjectSelector)
                objj_msgSend(self._delegate, "archiver:willReplaceObject:withObject:", self, anObject, object);
            if (self._delegateSelectors & _CPKeyedArchiverWillEncodeObjectSelector)
            {
                anObject = objj_msgSend(self._delegate, "archiver:willEncodeObject:", self, object);
                if (anObject !== object && self._delegateSelectors & _CPKeyedArchiverWillReplaceObjectWithObjectSelector)
                    objj_msgSend(self._delegate, "archiver:willReplaceObject:withObject:", self, object, anObject);
                object = anObject;
            }
        }
        objj_msgSend(self._replacementObjects, "setObject:forKey:", object, hash);
    }
    if (object === nil)
        return _CPKeyedArchiverNullReference;
    var UID = objj_msgSend(self._UIDs, "objectForKey:", hash = objj_msgSend(object, "hash"));
    if (UID === nil)
    {
        if (isConditional)
        {
            if ((UID = objj_msgSend(self._conditionalUIDs, "objectForKey:", hash)) === nil)
            {
                objj_msgSend(self._conditionalUIDs, "setObject:forKey:", UID = objj_msgSend(self._plistObjects, "count"), hash);
                objj_msgSend(self._plistObjects, "addObject:", _CPKeyedArchiverNullString);
            }
        }
        else
        {
            var theClass = objj_msgSend(anObject, "classForKeyedArchiver"),
                plistObject = nil;
            if ((theClass === _CPKeyedArchiverStringClass) || (theClass === _CPKeyedArchiverNumberClass))
                plistObject = object;
            else
            {
                plistObject = objj_msgSend(CPDictionary, "dictionary");
                objj_msgSend(self._objects, "addObject:", object);
                var className = objj_msgSend(self, "classNameForClass:", theClass);
                if (!className)
                    className = objj_msgSend(objj_msgSend(self, "class"), "classNameForClass:", theClass);
                if (!className)
                    className = theClass.name;
                else
                    theClass = window[className];
                var classUID = objj_msgSend(self._UIDs, "objectForKey:", className);
                if (!classUID)
                {
                    var plistClass = objj_msgSend(CPDictionary, "dictionary"),
                        hierarchy = [];
                    objj_msgSend(plistClass, "setObject:forKey:", className, _CPKeyedArchiverClassNameKey);
                    do
                    {
                        objj_msgSend(hierarchy, "addObject:", CPStringFromClass(theClass));
                    } while (theClass = objj_msgSend(theClass, "superclass"));
                    objj_msgSend(plistClass, "setObject:forKey:", hierarchy, _CPKeyedArchiverClassesKey);
                    classUID = objj_msgSend(self._plistObjects, "count");
                    objj_msgSend(self._plistObjects, "addObject:", plistClass);
                    objj_msgSend(self._UIDs, "setObject:forKey:", classUID, className);
                }
                objj_msgSend(plistObject, "setObject:forKey:", objj_msgSend(CPDictionary, "dictionaryWithObject:forKey:", classUID, _CPKeyedArchiverUIDKey), _CPKeyedArchiverClassKey);
            }
            UID = objj_msgSend(self._conditionalUIDs, "objectForKey:", hash);
            if (UID !== nil)
            {
                objj_msgSend(self._UIDs, "setObject:forKey:", UID, hash);
                objj_msgSend(self._plistObjects, "replaceObjectAtIndex:withObject:", UID, plistObject);
            }
            else
            {
                objj_msgSend(self._UIDs, "setObject:forKey:", UID = objj_msgSend(self._plistObjects, "count"), hash);
                objj_msgSend(self._plistObjects, "addObject:", plistObject);
            }
        }
    }
    return objj_msgSend(CPDictionary, "dictionaryWithObject:forKey:", UID, _CPKeyedArchiverUIDKey);
}

