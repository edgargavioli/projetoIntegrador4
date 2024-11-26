package com.inventario.imobilizado.controller;


import com.inventario.imobilizado.model.*;
import com.inventario.imobilizado.repository.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;
import com.inventario.imobilizado.utils.DateUtils;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Collections;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("page")
public class HtmlController {
    private UserController userController = new UserController();
    private ItemController itemController = new ItemController();


    @Autowired
    private ItemInterface itemInterface;
    @Autowired
    private UserInterface userInterface;
    @Autowired
    private ModeloInterface modeloInterface;
    @Autowired
    private BrandInterface brandInterface;
    @Autowired
    private EmprestanteInterface emprestanteInterface;
    @Autowired
    private EmprestanteController emprestanteController;

    @GetMapping("/login")
    public ModelAndView loginForm(Model model) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("login");
        return modelAndView;
    }

    @GetMapping("/logon")
    public ModelAndView logonForm(Model model) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("logon");
        return modelAndView;
    }

    @Autowired
    private CategoryInterface categoryInterface;

    @GetMapping("/infoGeral")
    public ModelAndView infoGeral(@RequestParam(name = "pageSize", required = false, defaultValue = "12") Integer pageSize,
                                  @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
                                  @RequestParam(name = "order", required = false, defaultValue = "nome") String order) {
        ModelAndView modelAndView = new ModelAndView();

        // Ensure page size and page number are within valid range
        pageSize = Math.max(1, pageSize);
        page = Math.max(0, page);

        Page<Item> itemList = itemController.PagedItem(page, pageSize, itemInterface, order);
        List<Category> categories = categoryInterface.findAll(); // Fetch categories

        modelAndView.addObject("item", itemList.getContent()); // Add items to the model
        modelAndView.addObject("page", itemList); // Add page information to the model
        modelAndView.addObject("categories", categories); // Add categories to the model
        modelAndView.setViewName("infoGeral");

        return modelAndView;
    }

    @GetMapping("/Usuarios")
    public ModelAndView usuarios(@RequestParam(name = "pageSize", required = false, defaultValue = "12") Integer pageSize,
                                 @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
                                 @RequestParam(name = "order", required = false, defaultValue = "nome") String order) {
        ModelAndView modelAndView = new ModelAndView();

        // Ensure page size and page number are within valid range
        pageSize = Math.max(1, pageSize);
        page = Math.max(0, page);


        Page<User> userList = userController.PagedUser(page, pageSize, userInterface, order);

        modelAndView.addObject("usuarios", userList.getContent()); // Add users to the model
        modelAndView.addObject("page", userList); // Add page information to the model
        modelAndView.setViewName("Usuarios");

        return modelAndView;
    }


    @GetMapping("/Avisos")
    public ModelAndView getAvisos() {
        List<Item> items = itemInterface.findAll();
        Date currentDate = new Date();
        List<Item> overdueItems = new ArrayList<>();

        for (Item item : items) {
            if (item.getProxima_qualificacao().before(currentDate)) {
                overdueItems.add(item);
            }
        }

        List<Boolean> isOverdue = overdueItems.stream()
                .map(item -> item.getProxima_qualificacao().before(currentDate))
                .collect(Collectors.toList());

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("overdueItems", overdueItems);
        modelAndView.addObject("isOverdue", isOverdue);
        modelAndView.addObject("dateUtils", new DateUtils());
        modelAndView.setViewName("Avisos");

        return modelAndView;
    }


    @GetMapping("/infoEspecifica")
    public ModelAndView infoEspecifica(@RequestParam(name = "id") Integer id, Model model) {
        ModelAndView modelAndView = new ModelAndView();
        Item item = itemInterface.findById(id).get();
        modelAndView.addObject("item", item);
        modelAndView.setViewName("infoEspecifica");


        List<Action> actions = actionInterface.findByItem_IdItem(id);
        Collections.reverse(actions);
        modelAndView.addObject("actions", actions);



        return modelAndView;
    }

    @GetMapping("/NovoCadastro")
    public ModelAndView novoCadastro(Model model) {
        ModelAndView modelAndView = new ModelAndView();

        List<Item> allItens = itemInterface.findAll();
        Integer id = allItens.get(allItens.size() - 1).getId_item() + 1;

        List<Category> categories = categoryInterface.findAll();
        List<Location> locations = locationInterface.findAll();
        List<Modelo> modelo = modeloInterface.findAll();
        List<Brand> brands = brandInterface.findAll();

        modelAndView.addObject("id", id);
        modelAndView.addObject("brands", brands);
        modelAndView.addObject("modelo", modelo);
        modelAndView.addObject("categories", categories);
        modelAndView.addObject("locations", locations);

        modelAndView.addObject("data", new RequestItem());
        modelAndView.addObject("isEdit", false);

        modelAndView.setViewName("NovoCadastro");

        return modelAndView;
    }

    @GetMapping("/EditarItem")
    public ModelAndView editarItem(@RequestParam(name = "id") Integer id) {
        ModelAndView modelAndView = new ModelAndView();

        Item item = itemInterface.findById(id).orElseThrow(() -> new IllegalArgumentException("Invalid item Id:" + id));

        List<Category> categories = categoryInterface.findAll();
        List<Location> locations = locationInterface.findAll();
        List<Modelo> modelo = modeloInterface.findAll();
        List<Brand> brands = brandInterface.findAll();

        modelAndView.addObject("id", id);
        modelAndView.addObject("brands", brands);
        modelAndView.addObject("modelo", modelo);
        modelAndView.addObject("categories", categories);
        modelAndView.addObject("locations", locations);

        modelAndView.addObject("data", item);
        modelAndView.addObject("isEdit", true);

        modelAndView.setViewName("NovoCadastro");

        return modelAndView;
    }

    @GetMapping("/Emprestimo")
    public ModelAndView Emprestimo(@RequestParam(name = "id") Integer id, Model model) {
        ModelAndView modelAndView = new ModelAndView();
        Action action = new Action();

        Item item = itemInterface.findById(id).get();
        if (item.getEstado().equals("Emprestado") || item.getEstado().equals("Manutenção")) {
            System.out.println("item Indisponível");

            return new ModelAndView("redirect:/page/infoGeral");
        }
        action.setItem(item);

        modelAndView.addObject("action", action);

        List<Location> locations = locationInterface.findAll();
        List<User> users = userInterface.findAll();
        List<Emprestante> emprestantes = emprestanteInterface.findAll();


        modelAndView.addObject("locations", locations);
        modelAndView.addObject("users", users);
        modelAndView.addObject("emprestantes", emprestantes);


        modelAndView.setViewName("Emprestimo");
        //      guardando id item
        ActionRequest actionRequest = new ActionRequest();
        actionRequest.setId_item(id);

        modelAndView.addObject("data", actionRequest);

        return modelAndView;
    }

    @GetMapping("/Devolucao")
    public ModelAndView Devolucao(@RequestParam(name = "id") Integer id, Model model) {

        List<Action> actionDevolucao = actionInterface.findByItem_IdItem(id);

        Action lastAction;
        if (!actionDevolucao.isEmpty()) {
            lastAction = actionDevolucao.get(actionDevolucao.size() - 1);
            if (lastAction.getTipo_acao() == 0){
                System.out.println("item já devolvido");
                return new ModelAndView("redirect:/page/infoGeral");
            }
            else {
                Action devolver = new Action();
                devolver.setEmprestante(lastAction.getEmprestante());
                devolver.setEntidade(lastAction.getEntidade());
                devolver.setData_emprestimo(lastAction.getData_emprestimo());
                devolver.setData_devolucao(lastAction.getData_devolucao());
                devolver.setUsuario(lastAction.getUsuario());
                devolver.setItem(lastAction.getItem());
                devolver.setTipo_acao(0);
                devolver.setAnexos(lastAction.getAnexos());
                devolver.setLocalizacao_id_localizacao(lastAction.getLocalizacao_id_localizacao());

                actionInterface.save(devolver);
            }
        } else {
            System.out.println("Nenhuma ação encontrada para o item com ID: " + id);
        }

        itemInterface.findById(id).map(item -> {
            item.setEstado("Disponivel");
            return itemInterface.save(item);
        }).orElseThrow();


        return new ModelAndView("redirect:/page/infoGeral");
    }


    @GetMapping("/activeFieldRegistration")
    public ModelAndView activeFieldRegistration(Model model) {
        ModelAndView modelAndView = new ModelAndView();
        List<Brand> brands = brandInterface.findAll();
        List<Modelo> modelos = modeloInterface.findAll();
        List<Category> categories = categoryInterface.findAll();
        modelAndView.addObject("brands", brands);
        modelAndView.addObject("modelos", modelos);
        modelAndView.addObject("categories", categories);
        modelAndView.addObject("activeField", new ActiveFieldForm());
        modelAndView.setViewName("activeFieldRegistration");
        return modelAndView;
    }

    @Autowired
    private LocationInterface locationInterface;

    @GetMapping("/location")
    public ModelAndView NovaLocalizacao(Model model) {
        ModelAndView modelAndView = new ModelAndView();
        List<Location> locations = locationInterface.findAll();
        modelAndView.addObject("locations", locations);
        modelAndView.addObject("location", new Location());
        modelAndView.setViewName("location");
        return modelAndView;
    }

    private static final Logger logger = LoggerFactory.getLogger(HtmlController.class);

    @Autowired
    private AttachmentInterface attachmentInterface;

    @Autowired
    private ActionInterface actionInterface;

    @PostMapping("/Emprestimo")
    public ModelAndView registrarEmprestimo(@ModelAttribute ActionRequest action, @RequestParam(name = "id") Integer id) {
        action.setId_item(id);

        Action postAction = new Action();
        postAction.setEmprestante(emprestanteInterface.findByNumIdentificacao(action.getNum_identificacao_emprestante()));
        postAction.setEntidade(action.getEntidade());
        postAction.setData_emprestimo(action.getData_emprestimo());
        postAction.setData_devolucao(action.getData_devolucao());
        postAction.setUsuario(userInterface.findById(action.getId_usuario()).get());
        postAction.setItem(itemInterface.findById(action.getId_item()).get());
        postAction.setTipo_acao(1);
        postAction.setAnexos(attachmentInterface.findById(1).get());
        postAction.setLocalizacao_id_localizacao(action.getId_localizacao_atual());

        actionInterface.save(postAction);
        // altera a disponibilidade do item
        itemInterface.findById(id).map(item -> {
            item.setEstado(action.getEstado());
            item.setPrazo_manutencao(action.getPrazo_manutencao());
            return itemInterface.save(item);
        }).orElseThrow();

        return new ModelAndView("redirect:/page/infoGeral");
    }


    @PostMapping("/NovoCadastro")
    public ModelAndView registrarProduto(@ModelAttribute RequestItem data) {
        Item item;

        if (data.getId_item() != null && itemInterface.existsById(data.getId_item())) {
            item = itemInterface.findById(data.getId_item()).orElseThrow(() -> new IllegalArgumentException("Invalid item Id:" + data.getId_item()));
        } else {
            item = new Item();
        }

        item.setId_item(data.getId_item());
        item.setDescricao(data.getDescricao());
        item.setPotencia(data.getPotencia());
        item.setPatrimonio(data.getPatrimonio());
        item.setData_nota_fiscal(data.getData_nota_fiscal());
        item.setLocalizacao_atual(data.getLocalizacao_atual());
        item.setData_entrada(data.getData_entrada());
        item.setUltima_qualificacao(data.getUltima_qualificacao());
        item.setProxima_qualificacao(data.getProxima_qualificacao());
        item.setNumero_de_serie(data.getNumero_de_serie());
        item.setComentario_manutencao(data.getComentario_manutencao());
        item.setPrazo_manutencao(data.getPrazo_manutencao());
        item.setNumero_nota_fiscal(data.getNumero_nota_fiscal());
        item.setEstado(data.getEstado());
        item.setStatus(data.getStatus());

        item.setModelo(modeloInterface.findById(data.getModelo()).get());
        item.setCategoria(categoryInterface.findById(data.getCategoria()).get());
        item.setLocalizacao(locationInterface.findById(data.getLocalizacao()).get());

        System.out.println("item:" + item.toString());
        System.out.println("data:" + data.toString());

        itemInterface.save(item);
        return new ModelAndView("redirect:/page/infoGeral");
    }

    @GetMapping("/Emprestantes")
    public ModelAndView emprestante(@RequestParam(name = "pageSize", required = false, defaultValue = "12") Integer pageSize,
                                 @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
                                 @RequestParam(name = "order", required = false, defaultValue = "nome") String order) {
        ModelAndView modelAndView = new ModelAndView();

        // Ensure page size and page number are within valid range
        pageSize = Math.max(1, pageSize);
        page = Math.max(0, page);


        Page<Emprestante> emprestantesList = emprestanteController.PagedUser(page, pageSize, emprestanteInterface, order);

        modelAndView.addObject("emprestantes", emprestantesList.getContent()); // Add users to the model
        modelAndView.addObject("page", emprestantesList); // Add page information to the model
        modelAndView.setViewName("Emprestantes");

        return modelAndView;
    }

    @GetMapping("/NovoEmprestante")
    public ModelAndView novoEmprestante(Model model) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("data", new Emprestante());
        modelAndView.setViewName("NovoEmprestante");
        return modelAndView;
    }

    @PostMapping("/NovoEmprestante")
    public ModelAndView registrarEmprestante(@ModelAttribute Emprestante data) {
        emprestanteController.createEmprestante(data);
        return new ModelAndView("redirect:/page/Emprestantes");
    }

}