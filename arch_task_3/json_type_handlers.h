#pragma once

#include <Poco/JSON/Object.h>
#include <Poco/JSON/Array.h>
#include <Poco/JSON/Parser.h>
#include <Poco/Data/TypeHandler.h>

namespace Poco {
namespace Data {

template <typename T>
class JSONTypeHandler
{
public:
    static std::size_t size()
    {
        return 1;
    }

    static void bind(std::size_t pos, const T& obj, AbstractBinder::Ptr pBinder, AbstractBinder::Direction dir)
    {
        std::ostringstream oss;
        obj.stringify(oss);
        std::string json = oss.str();
        TypeHandler<std::string>::bind(pos, json, pBinder, dir);
    }

    static void extract(std::size_t pos, T& obj, const T& defVal, AbstractExtractor::Ptr pExt)
    {
        std::string json;
        TypeHandler<std::string>::extract(pos, json, std::string(), pExt);
        if (!json.empty())
        {
            Poco::JSON::Parser parser;
            Poco::Dynamic::Var result = parser.parse(json);
            obj = result.extract<T>();
        }
        else
        {
            obj = defVal;
        }
    }

    static void prepare(std::size_t pos, const T& obj, AbstractPreparator::Ptr pPreparator)
    {
        std::ostringstream oss;
        obj.stringify(oss);
        std::string json = oss.str();
        TypeHandler<std::string>::prepare(pos, json, pPreparator);
    }
};

template <>
class TypeHandler<Poco::JSON::Object> : public JSONTypeHandler<Poco::JSON::Object>
{
};

template <>
class TypeHandler<Poco::JSON::Array> : public JSONTypeHandler<Poco::JSON::Array>
{
};

} // namespace Data
} // namespace Poco