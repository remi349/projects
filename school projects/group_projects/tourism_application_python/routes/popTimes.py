import importlib.util


spec = importlib.util.spec_from_file_location("populartimes", "/home/ubuntu/Test/routes/populartimes/populartimes/__init__.py")
pt = importlib.util.module_from_spec(spec)
spec.loader.exec_module(pt)


data = (pt.get_id("AIzaSyATLwi1Cm_OT9klk8061h2FKgCeRQG-nVo", "ChIJD3uTd9hx5kcR1IQvGfr8dbk"))
print (data)