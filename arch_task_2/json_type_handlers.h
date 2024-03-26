#pragma once

#include <Poco/JSON/Object.h>
#include <Poco/JSON/Array.h>
#include <Poco/JSON/Parser.h>
#include <Poco/Data/TypeHandler.h>

namespace Poco {
namespace Data {

template <>
class TypeHandler<Poco::JSON::Object>
{
public:
    static std::size_t size()
    {
        return 1;
    }

    static void bind(std::size_t pos, const Poco::JSON::Object& obj, AbstractBinder::Ptr pBinder, AbstractBinder::Direction dir)
    {
        std::ostringstream oss;
        obj.stringify(oss);
        std::string json = oss.str();
        TypeHandler<std::string>::bind(pos, json, pBinder, dir);
    }

    static void extract(std::size_t pos, Poco::JSON::Object& obj, const Poco::JSON::Object& defVal, AbstractExtractor::Ptr pExt)
    {
        std::string json;
        TypeHandler<std::string>::extract(pos, json, "", pExt);
        if (!json.empty())
        {
            Poco::JSON::Parser parser;
            obj = parser.parse(json).extract<Poco::JSON::Object>();
        }
        else
        {
            obj = defVal;
        }
    }

    static void prepare(std::size_t pos, const Poco::JSON::Object& obj, AbstractPreparator::Ptr pPreparator)
    {
        std::ostringstream oss;
        obj.stringify(oss);
        std::string json = oss.str();
        TypeHandler<std::string>::prepare(pos, json, pPreparator);
    }
};

template <>
class TypeHandler<Poco::JSON::Array>
{
public:
    static std::size_t size()
    {
        return 1;
    }

    static void bind(std::size_t pos, const Poco::JSON::Array& arr, AbstractBinder::Ptr pBinder, AbstractBinder::Direction dir)
    {
        std::ostringstream oss;
        arr.stringify(oss);
        std::string json = oss.str();
        TypeHandler<std::string>::bind(pos, json, pBinder, dir);
    }

    static void extract(std::size_t pos, Poco::JSON::Array& arr, const Poco::JSON::Array& defVal, AbstractExtractor::Ptr pExt)
    {
        std::string json;
        TypeHandler<std::string>::extract(pos, json, "", pExt);
        if (!json.empty())
        {
            Poco::JSON::Parser parser;
            arr = parser.parse(json).extract<Poco::JSON::Array>();
        }
        else
        {
            arr = defVal;
        }
    }

    static void prepare(std::size_t pos, const Poco::JSON::Array& arr, AbstractPreparator::Ptr pPreparator)
    {
        std::ostringstream oss;
        arr.stringify(oss);
        std::string json = oss.str();
        TypeHandler<std::string>::prepare(pos, json, pPreparator);
    }
};

} // namespace Data
} // namespace Poco